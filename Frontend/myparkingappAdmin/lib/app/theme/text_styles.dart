import 'package:flutter/material.dart';

class AppTextStyles {
  // Kiểu chữ chung cho Light Theme
  static const TextStyle appBarTitleLight = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const TextStyle bodyTextLight = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
    color: Colors.black87,
  );

  static const TextStyle headlineLight = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  // Kiểu chữ chung cho Dark Theme
  static const TextStyle appBarTitleDark = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle bodyTextDark = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
    color: Colors.white,
  );

  static const TextStyle headlineDark = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  // TextTheme Light
  static const TextTheme textThemeLight = TextTheme(
    displayLarge: headlineLight,
    bodyLarge: bodyTextLight,
  );

  // TextTheme Dark
  static const TextTheme textThemeDark = TextTheme(
    displayLarge: headlineDark,
    bodyLarge: bodyTextDark,
  );
}
