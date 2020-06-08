import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_template/launcher/router/transition_animation.dart';
import 'package:my_flutter_template/page/web_view_page.dart';


class XRouter {
  static Router router;
  
  static void init() {
    router = Router();
    configureRoutes(router);
  }

  static void configureRoutes(Router router) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("route is not find !");
      return null;
    });

      //网页加载
    router.define('/web', handler: Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String title = params['title']?.first;
      String url = params['url']?.first;
      return WebViewPage(url, title);
    }));
  }

  static void goto(BuildContext context, String pageName) {
    Navigator.push(context, SlidePageRoute(routeName: pageName));
  }

  static void gotoWidget(BuildContext context, Widget widget) {
    Navigator.push(context, SlidePageRoute(widget: widget));
  }
}