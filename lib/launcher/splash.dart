import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_flutter_template/launcher/router/route_map.dart';
import 'package:my_flutter_template/utils/sputils.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    countDown();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white
      ),
      child: Center(
        child: FlutterLogo(size: 96,),
      ),
    );
  }

  void countDown() {
    var _duration = Duration(seconds: 2);
    new Future.delayed(_duration, goHomePage);
  }

  void goHomePage() {
    String nickName = SPUtils.getNickName();
    if(nickName != null && nickName.isNotEmpty) {
      Navigator.of(context).pushReplacementNamed(RouteMap.homePage);
    }else {
      Navigator.of(context).pushReplacementNamed(RouteMap.loginPage);
    }
  }
  
}