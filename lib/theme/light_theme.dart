import 'dart:ui';

import 'package:flutter/material.dart';

class LightTheme {
  static Color main = const Color(0xFFFF7700);
  static Color secondary = const Color.fromRGBO(255, 157, 71, 1);
  static Color third = const Color.fromARGB(146, 255, 157, 71);
  static Color background = Colors.white;
  static Color mainText = Colors.black;
  static Color textBlack = Colors.black;
  static Color textWhite = Colors.white;
  static Color favorite = const Color.fromRGBO(243, 121, 97, 1);
  static Color textGray = Colors.grey[700]!;
  static Color textGray2 = Colors.grey[200]!;
  static Color textGray3 = Colors.grey[500]!;
  static Color green = Colors.green[500]!;
  static Color red = Colors.red[500]!;
  static Color transparent = Colors.transparent;

  static TextStyle textStyle({double fontSize = 24, Color? color}) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      fontFamily: 'Tajawal-Regular',
      color: color,
      decoration: TextDecoration.none,
    );
  }

  static MediaQueryData mediaQueryData = MediaQueryData.fromView(window);
}
