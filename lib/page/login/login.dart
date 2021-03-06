import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_flutter_template/generated/i18n.dart';
import 'package:my_flutter_template/network/api.dart';
import 'package:my_flutter_template/network/http_manager.dart';
import 'package:my_flutter_template/network/result.dart';
import 'package:my_flutter_template/page/login/channel.dart';
import 'package:my_flutter_template/page/login/loading_dialog.dart';
import 'package:my_flutter_template/page/login/privacy.dart';
import 'package:my_flutter_template/launcher/router/route_map.dart';
import 'package:my_flutter_template/launcher/router/router.dart';
import 'package:my_flutter_template/utils/provider.dart';
import 'package:my_flutter_template/utils/sputils.dart';
import 'package:my_flutter_template/utils/toast.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool _isShowPassWord = false;
  FocusNode blankNode = FocusNode();
  TextEditingController _unameController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  GlobalKey _formKey = GlobalKey<FormState>();
  
  @override
  void initState() {
    super.initState();
    if(!SPUtils.isAgreePrivacy()) {
      PrivacyUtils.showPrivacyDialog(context, onAgressCallback: () {
        Navigator.of(context).pop();
        SPUtils.saveIsAgreePrivacy(true);
        ToastUtils.success(I18n.of(context).agreePrivacy);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope (
      child: Scaffold(
        appBar: AppBar(
          title: Text(I18n.of(context).login),
          actions: <Widget>[
            FlatButton(
              child: Text(I18n.of(context).register),
              textColor: Colors.white,
              onPressed: () {
                XRouter.goto(context, RouteMap.registerPage);
              },
            )
          ],
        ),
        body: GestureDetector(
          onTap: () {
            // 点击空白 关闭键盘
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
            child: buildForm(context),
          ),
        ),
      ),
      onWillPop: () async {
        return Future.value(false);
      },
    );
  }

  //构建表单
  Widget buildForm(BuildContext context) {
    return Form(
      key: _formKey, //设置globalKey，用于后面获取FormState
      autovalidate: false,
      child: Column(
        children: <Widget>[
          Center(
              heightFactor: 1.5,
              child: FlutterLogo(
                size: 64,
              )),
          TextFormField(
              autofocus: false,
              controller: _unameController,
              decoration: InputDecoration(
                  labelText: I18n.of(context).loginName,
                  hintText: I18n.of(context).loginNameHint,
                  hintStyle: TextStyle(fontSize: 12),
                  icon: Icon(Icons.person)),
              //校验用户名
              validator: (v) {
                return v.trim().length > 0
                    ? null
                    : I18n.of(context).loginNameError;
              }),
          TextFormField(
              controller: _pwdController,
              decoration: InputDecoration(
                  labelText: I18n.of(context).password,
                  hintText: I18n.of(context).passwordHint,
                  hintStyle: TextStyle(fontSize: 12),
                  icon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                      icon: Icon(
                        _isShowPassWord
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.black,
                      ),
                      onPressed: showPassWord)),
              obscureText: !_isShowPassWord,
              //校验密码
              validator: (v) {
                return v.trim().length >= 6
                    ? null
                    : I18n.of(context).passwordError;
              }),
          // 登录按钮
          Padding(
            padding: const EdgeInsets.only(top: 28.0),
            child: Row(
              children: <Widget>[
                Expanded(child: Builder(builder: (context) {
                  return RaisedButton(
                    padding: EdgeInsets.all(15.0),
                    child: Text(I18n.of(context).login),
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

  void showPassWord() {
    setState(() {
      _isShowPassWord = !_isShowPassWord;
    });
  }

    void closeKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(blankNode);
  }

  //验证通过提交数据
  Future<void> onSubmit(BuildContext context) async {
    closeKeyboard(context);

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return LoadingDialog(
            showContent: false,
            backgroundColor: Colors.black38,
            loadingView: SpinKitCircle(color: Colors.white,),
          );
        });

    UserProfile userProfile = Provider.of<UserProfile>(context, listen: false);

    final Result result = await HttpManager.instance.request(APIs.fetchChannel);
    if(result.type == ResultType.success) {
      Navigator.pop(context);
      ToastUtils.toast(I18n.of(context).loginSuccess);
      ChannelModel model = ChannelModel.fromJson(result.data);
      print(model.channels[0].name);
      Navigator.of(context).pushReplacementNamed(RouteMap.homePage);
    }else {
      print(result.data);
      Navigator.pop(context);
    }

    
  //   XHttp.post("/user/login", {
  //     "username": _unameController.text,
  //     "password": _pwdController.text
  //   }).then((response) {
  //     Navigator.pop(context);
  //     if (response['errorCode'] == 0) {
  //       userProfile.nickName = response['data']['nickname'];
  //       ToastUtils.toast(I18n.of(context).loginSuccess);
  //       Navigator.of(context).pushReplacementNamed('/home');
  //     } else {
  //       ToastUtils.error(response['errorMsg']);
  //     }
  //   }).catchError((onError) {
  //     Navigator.of(context).pop();
  //     ToastUtils.error(onError);
  //   });
  }

}