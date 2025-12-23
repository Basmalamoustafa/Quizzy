import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/user_model.dart';
import 'profile_screen.dart';
import 'quizlist_screen.dart';
import 'home_view.dart';
import 'fun_fact_screen.dart';
import 'gallery_screen.dart';
import 'faq_screen.dart';


class HomeScreen extends StatefulWidget {
  final User user;

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


    _screens = [
      HomeView(user: widget.user),
      QuizListScreen(user: widget.user),
      const FunFactScreen(),
      const QuoteGalleryScreen(),
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
    extendBody: false,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    body: _screens[_selectedIndex],


    bottomNavigationBar: BottomNavigationBar(
      backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      type: BottomNavigationBarType.fixed,
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
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
