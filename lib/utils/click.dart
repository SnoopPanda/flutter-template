import 'package:flutter/material.dart';
import 'package:my_flutter_template/utils/toast.dart';

class ClickUtils {
  ClickUtils._internal();
  
  static DateTime _lastPressedAt;
  
  static Future<bool> exitBy2Click(
    { int duration = 1000, ScaffoldState status}) async {
      if(status != null && status.isDrawerOpen) {
        return Future.value(true);
      }

      if(_lastPressedAt == null || DateTime.now().difference(_lastPressedAt) > Duration(milliseconds: duration)) {
        ToastUtils.toast("再按一次退出程序");
        _lastPressedAt = DateTime.now();
        return Future.value(false);
      }
      return Future.value(true);
    }
}