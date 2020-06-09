import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_flutter_template/generated/i18n.dart';
import 'package:my_flutter_template/network/api.dart';
import 'package:my_flutter_template/network/http_manager.dart';
import 'package:my_flutter_template/network/result.dart';
import 'package:my_flutter_template/utils/toast.dart';

import 'loading_dialog.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isShowPassword = false;
  bool _isShowPasswordRepeat = false;

  FocusNode blankNode = FocusNode();

  TextEditingController _unameController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  TextEditingController _pwdRepeatController = TextEditingController();

  GlobalKey _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(I18n.of(context).register),
      ),
      body: GestureDetector(
        onTap: () {
          closeKeyboard(context);
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
          child: buildForm(context),
        ),
      ),
    );
  }

  void closeKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(blankNode);
  }

  Widget buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidate: false,
      child: Column(
        children: <Widget>[
          TextFormField(
            autofocus: false,
            controller: _unameController,
            decoration: InputDecoration(
                labelText: I18n.of(context).loginName,
                hintText: I18n.of(context).loginNameHint,
                hintStyle: TextStyle(fontSize: 12),
                icon: Icon(Icons.person)),
            validator: (v) {
              return v.trim().length > 0
                  ? null
                  : I18n.of(context).loginNameError;
            },
          ),
          TextFormField(
            controller: _pwdController,
            decoration: InputDecoration(
                labelText: I18n.of(context).password,
                hintText: I18n.of(context).passwordHint,
                hintStyle: TextStyle(fontSize: 12),
                icon: Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isShowPassword ? Icons.visibility : Icons.visibility_off,
                    color: Colors.black,
                  ),
                  onPressed: showPassword,
                )),
            obscureText: !_isShowPassword,
            validator: (v) {
              return v.trim().length >= 6
                  ? null
                  : I18n.of(context).passwordError;
            },
          ),
          TextFormField(
            controller: _pwdRepeatController,
            decoration: InputDecoration(
              labelText: I18n.of(context).repeatPassword,
              hintText: I18n.of(context).passwordHint,
              hintStyle: TextStyle(fontSize: 12),
              icon: Icon(Icons.lock),
              suffixIcon: IconButton(
                icon: Icon(_isShowPasswordRepeat
                    ? Icons.visibility
                    : Icons.visibility_off),
                color: Colors.black,
                onPressed: showPasswordRepeat,
              ),
            ),
            obscureText: !_isShowPasswordRepeat,
            validator: (v) {
              return v.trim().length >= 6
                  ? null
                  : I18n.of(context).passwordError;
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 28.0),
            child: Row(
              children: <Widget>[
                Expanded(child: Builder(builder: (context) {
                  return RaisedButton(
                    padding: EdgeInsets.all(15.0),
                    child: Text(I18n.of(context).register),
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    onPressed: () {
                      //由于本widget也是Form的子代widget，所以可以通过下面方式获取FormState
                      if (Form.of(context).validate()) {
                        onSubmit(context);
                      }
                    },
                  );
                })),
              ],
            ),
          )
        ],
      ),
    );
  }

  void showPassword() {
    setState(() {
      _isShowPassword = !_isShowPassword;
    });
  }

  void showPasswordRepeat() {
    setState(() {
      _isShowPasswordRepeat = !_isShowPasswordRepeat;
    });
  }

  void onSubmit(BuildContext context) async {
    closeKeyboard(context);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
          return LoadingDialog(
            showContent: false,
            backgroundColor: Colors.black38,
            loadingView: SpinKitCircle(color: Colors.white),
          );
        });
    
    // 注册接口
    final Result result = await HttpManager.instance.request(APIs.fetchChannel);
    if(result.type == ResultType.success) {
      Navigator.pop(context);
      ToastUtils.toast(I18n.of(context).registerSuccess);
      Navigator.of(context).pop();
    }else {
      Navigator.pop(context);
    }
  }
}
