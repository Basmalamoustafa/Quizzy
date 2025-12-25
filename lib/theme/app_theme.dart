import 'package:flutter/material.dart';

// Define the app's light and dark themes
class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,

    // Purple and pink color scheme
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF8B5CF6),
      secondary: Color(0xFFEC4899),
      background: Color(0xFFF6F2FF),
      surface: Color(0xFFFFFFFF),
      onSurface: Color(0xFF1A1A1A),
      onBackground: Color(0xFF1A1A1A),
    ),

    scaffoldBackgroundColor: const Color(0xFFF6F2FF),

    shadowColor: const Color(0xFF8B5CF6).withOpacity(0.18),

    // Smooth fade transitions between pages
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
      },
    ),

    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 26,
        letterSpacing: -0.5,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        height: 1.4,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,

    // Dark theme with brighter purple/pink accents
    colorScheme: ColorScheme.dark(
      primary: const Color(0xFF9F7FFF),
      secondary: const Color(0xFFFF4FA8),
      background: const Color(0xFF0A0714),
      surface: const Color(0xFF171222).withOpacity(0.6),
      onSurface: Colors.white.withOpacity(0.92),
      onBackground: Colors.white.withOpacity(0.90),
    ),

    scaffoldBackgroundColor: const Color(0xFF0A0714),

    shadowColor: const Color(0xFFEC4899).withOpacity(0.45),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF0F0B1E),
      elevation: 0,
    ),

    // Same smooth transitions for dark mode
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
      },
    ),

    textTheme: TextTheme(
      headlineMedium: const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 26,
        letterSpacing: -0.5,
      ).copyWith(color: Colors.white),

      bodyMedium: const TextStyle(
        fontSize: 16,
        height: 1.4,
        color: Colors.white70,
      ),
    ),
  );
}
