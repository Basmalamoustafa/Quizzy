import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/user_model.dart';
import 'home_view.dart';
import 'fun_fact_screen.dart';
import 'gallery_screen.dart';
import 'faq_screen.dart';
import 'about_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  final User user;  // ⭐ we now pass the logged-in user

  const HomeScreen({super.key, required this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();

    // ⭐ PASS USER TO ANY SCREEN THAT NEEDS IT (HomeView & Profile)
    _screens = [
      HomeView(user: widget.user),
      Center(child: Text('Quiz Page Placeholder', style: TextStyle(fontSize: 20))),
      FunFactScreen(),
      QuoteGalleryScreen(),
      FAQScreen(),
      ProfileScreen(user: widget.user),
    ];
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
            icon: Icon(Icons.person_outline), // ⭐ PROFILE TAB
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
