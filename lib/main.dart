import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/quiz_provider.dart';
import 'providers/theme_provider.dart';  // ⭐ ADD THIS
import 'screens/login_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => QuizProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()), // ⭐ ADD THIS
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context); // ⭐ READ THEME

    return MaterialApp(
      title: 'Quizzy App',
      debugShowCheckedModeBanner: false,
      themeMode: themeProvider.themeMode,
      theme: ThemeProvider.lightTheme,
      darkTheme: ThemeProvider.darkTheme,

      home: const LoginScreen(),
    );
  }
}
