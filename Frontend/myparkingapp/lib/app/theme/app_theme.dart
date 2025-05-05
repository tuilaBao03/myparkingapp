

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import '../../constants.dart';

class AppTheme{
  static final ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 10,
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),

        ),
        shadowColor: Colors.black.withOpacity(1),

      ),
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: bodyTextColor),
      bodySmall: TextStyle(color: bodyTextColor),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      contentPadding: EdgeInsets.all(defaultPadding),
      hintStyle: TextStyle(color: bodyTextColor),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: primaryColorDark),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 10,
        backgroundColor: primaryColorDark,
        foregroundColor: Colors.black,
        minimumSize: const Size(double.infinity, 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        shadowColor: Colors.white.withOpacity(0.4),
      ),
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: bodyTextColorDark),
      bodySmall: TextStyle(color: bodyTextColorDark),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      contentPadding: EdgeInsets.all(defaultPadding),
      hintStyle: TextStyle(color: bodyTextColorDark),
    ),
  );

}