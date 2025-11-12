import 'package:flutter/material.dart';
import '/fun_fact_screen.dart';
import '/about_screen.dart';

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
        fontFamily: 'Inter', 
        primarySwatch: Colors.purple,
      ),
      home: const FunFactScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}