import 'package:flutter/material.dart';
import 'package:my_flutter_template/page/index.dart';
import 'package:my_flutter_template/page/login/login.dart';
import 'package:my_flutter_template/page/login/register.dart';

class RouteMap {

  static final homePage = '/home';
  static final loginPage = '/login';
  static final registerPage = '/register';
  static final settingsPage = '/settings';
  static final sponsorPage = '/sponsor';
  static final aboutPage = '/about';

  static final routes = <String, WidgetBuilder>{
    homePage: (BuildContext context) => MainHomePage(),
    loginPage: (BuildContext context) => LoginPage(),
    registerPage: (BuildContext context) => RegisterPage(),
    settingsPage: (BuildContext context) => MainHomePage(),
    sponsorPage: (BuildContext context) => MainHomePage(),
    aboutPage: (BuildContext context) => MainHomePage(),
  };
}
