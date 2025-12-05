import 'package:flutter/material.dart';

class AppTheme {
  // 🌞 LIGHT THEME
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF8B5CF6),
      secondary: Color(0xFFEC4899),
      background: Color(0xFFF9F5FF),
      surface: Colors.white,
      onSurface: Colors.black87,
      onBackground: Colors.black87,
    ),
    scaffoldBackgroundColor: const Color(0xFFF9F5FF),
    cardColor: Colors.white,
    useMaterial3: true,
  );

  // 🌙 DARK THEME (fixed + readable)
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF6D28D9),
      secondary: Color(0xFFBE185D),

      // 👇NEW COLORS (important)
      background: Color(0xFF0F0A1C),
      surface: Color(0xFF262037),
      onSurface: Color(0xFFE8E8E8),
      onBackground: Color(0xFFE0E0E0),
    ),

    scaffoldBackgroundColor: const Color(0xFF0F0A1C),

    cardColor: const Color(0xFF2F2842),

    useMaterial3: true,
  );
}
