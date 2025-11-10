import 'package:flutter/material.dart';
import '/fun_fact_screen.dart'; // Import your screen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fun Facts App',
      theme: ThemeData(
        // To use the 'Inter' font, you must first
        // 1. Download it from Google Fonts
        // 2. Add it to an `assets/fonts/` folder
        // 3. Declare it in your `pubspec.yaml`
        fontFamily: 'Inter', 
        primarySwatch: Colors.purple,
      ),
      home: const FunFactScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}