import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryDark = Color(0xFF14274E);
  static const Color primaryMedium = Color(0xFF394867);
  static const Color primaryLight = Color(0xFF9BA4B4);
  static const Color backgroundColor = Color(0xFFF1F6F9);

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryDark,
    scaffoldBackgroundColor: backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryDark,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    colorScheme: const ColorScheme.light(
      primary: primaryDark,
      secondary: primaryMedium,
      surface: backgroundColor,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primaryMedium, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red, width: 1.5),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryDark,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(color: primaryDark, fontWeight: FontWeight.bold, fontSize: 24),
      titleLarge: TextStyle(color: primaryDark, fontWeight: FontWeight.w600, fontSize: 20),
      bodyLarge: TextStyle(color: primaryMedium, fontSize: 16),
      bodyMedium: TextStyle(color: primaryLight, fontSize: 14),
    ),
  );
}