import 'package:flutter/material.dart';

import 'NavigatorKey.dart';

class Routes{
 static var context = NavigatorKey.navigatorKey.currentState?.overlay?.context;
  static Future pushPage(Widget widget) {
    return Navigator.push(
        context!,  MaterialPageRoute(builder: (context) => widget));
  }
   static popPage() {
    Navigator.pop(context!);
  }
}