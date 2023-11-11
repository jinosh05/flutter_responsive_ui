import "package:flutter/material.dart";

class AppTheme {
  AppTheme();
  static ThemeData lighttheme = ThemeData.light(useMaterial3: true).copyWith(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
    ),
  );
  static ThemeData darktheme = ThemeData.light(useMaterial3: true).copyWith();
}
