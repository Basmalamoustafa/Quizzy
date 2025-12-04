import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/about_screen.dart';
import 'package:flutter_application_1/screens/fun_fact_screen.dart';
import 'package:flutter_application_1/screens/gallery_screen.dart';
import 'home_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'faq_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _screens = <Widget>[
    HomeView(),
    Center(
        child: Text('Quiz Page Placeholder', style: TextStyle(fontSize: 20))),
    FunFactScreen(),
    QuoteGalleryScreen(),
    FAQScreen(),
    AboutScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF7FD),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: const Color(0xFF7F00FF),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_awesome_outlined),
            label: 'Quiz',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.bookOpen),
            label: 'Facts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_quote_outlined),
            label: 'Gallery',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help_outline),
            label: 'FAQ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            label: 'About',
          ),
        ],
      ),
    );
  }
}
