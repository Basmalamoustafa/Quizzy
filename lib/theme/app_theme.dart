import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF8B5CF6),
      secondary: Color(0xFFEC4899),
      background: Color(0xFFFDF7FD),
      surface: Colors.white,
      onSurface: Colors.black87,
      onBackground: Colors.black87,
    ),
    scaffoldBackgroundColor: const Color(0xFFFDF7FD),
    cardColor: Colors.white,
    useMaterial3: true,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF6D28D9),
      secondary: Color(0xFFBE185D),
      background: Color(0xFF0F0A1C),
      surface: Color(0xFF1A1028),
      onSurface: Colors.white70,
      onBackground: Colors.white70,
    ),
    scaffoldBackgroundColor: const Color(0xFF0F0A1C),
    cardColor: const Color(0xFF1A1028),
    useMaterial3: true,
  );
}
