import 'dart:async';
import 'package:flutter/material.dart';
import 'default_app.dart';

class AppInit {
  static void run() {
    catchException(() => DefaultApp.run());
  }

  static void catchException<T> (T callback()) {
    FlutterError.onError = (FlutterErrorDetails details) {
      reportErrorAndLog(details);
    };
    runZoned<Future<Null>> (
      () async {
        callback();
      },
      zoneSpecification: ZoneSpecification(
        print: (Zone self, ZoneDelegate parent, Zone zone, String line) {
          collectLog(parent, zone, line); // 收集日志
        },
      ),
      onError: (Object obj, StackTrace stack) {
        var details = makeDetails(obj, stack);
        reportErrorAndLog(details);
      }
    ); 
  }

    //日志拦截, 收集日志
  static void collectLog(ZoneDelegate parent, Zone zone, String line) {
    parent.print(zone, "日志拦截: $line");
  }

  //上报错误和日志逻辑
  static void reportErrorAndLog(FlutterErrorDetails details) {
    print(details);
  }

  // 构建错误信息
  static FlutterErrorDetails makeDetails(Object obj, StackTrace stack) {
    return FlutterErrorDetails(stack: stack);
  }
}