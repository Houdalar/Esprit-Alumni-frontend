import 'package:flutter/material.dart';

class AppColors {
  AppColors._();
  //static const Color primaryTextColor = Color(0xFF414C6B);
  static const Color transparent = Colors.transparent;
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color searchBarColor = Color.fromARGB(255, 237, 234, 234);
  static const Color searchBarHintTextClr = Color.fromARGB(255, 145, 145, 145);
  static const Color primaryColor = Color.fromARGB(255, 219, 58, 46);
  static const Color primaryColorDark = Color(0xFF7E1717);
  static const Color svgBackgroundClr = Color.fromARGB(255, 235, 206, 177);
  static const Color darkred = Color.fromARGB(255, 19, 5, 4);
  static const Color primaryDark = Color.fromARGB(255, 126, 23, 23);
  static const Color primary = Color.fromRGBO(244, 67, 54, 1);
  static const Color converBackgroundClr = Color.fromARGB(255, 240, 232, 232);
  static const gradient1 = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        AppColors.darkred,
        AppColors.primaryDark,
        AppColors.primary,
      ]);
}
