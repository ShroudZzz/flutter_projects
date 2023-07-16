import 'package:flutter/material.dart';

class NavigatorUtil {
  static push(BuildContext context, Widget widget) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return widget;
    }));
  }

  static pop(BuildContext context) {
    Navigator.pop(context);
  }
}