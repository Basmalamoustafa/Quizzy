import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/app_theme.dart'; // ⭐ ADD THIS

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeProvider() {
    _loadTheme();
  }

  ThemeMode get themeMode => _themeMode;

  bool get isDark => _themeMode == ThemeMode.dark;

  void toggleTheme() {
    _themeMode = isDark ? ThemeMode.light : ThemeMode.dark;
    _saveTheme();
    notifyListeners();
  }

  Future<void> _saveTheme() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("isDark", isDark);
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getBool("isDark") ?? false;

    _themeMode = saved ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  // ✔ Connect AppTheme class
  static ThemeData get lightTheme => AppTheme.lightTheme;
  static ThemeData get darkTheme => AppTheme.darkTheme;
}
