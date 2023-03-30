import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color.fromRGBO(244, 67, 54, 1);
  static const Color primaryDark = Color.fromARGB(255, 126, 23, 23);
  static const Color darkwhite = Color.fromARGB(255, 237, 237, 237);
  static const Color lightgray = Color(0xFFE0E0E0);
  static const Color darkgray = Color.fromARGB(255, 130, 130, 130);
  static const Color darkred = Color.fromARGB(255, 19, 5, 4);
  static const gradient1 = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        AppColors.darkred,
        AppColors.primaryDark,
        AppColors.primary,
      ]);
}
