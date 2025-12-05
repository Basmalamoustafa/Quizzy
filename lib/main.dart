import 'package:flutter/material.dart';
import 'pages/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quizzy App',
      theme: ThemeData(
        fontFamily: 'Inter', 
        primarySwatch: Colors.purple,
      ),
      home: const LoginScreen(), 
      debugShowCheckedModeBanner: false,
    );
  }
}