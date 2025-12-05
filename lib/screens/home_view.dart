import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../widgets/buildcard.dart';
import 'fun_fact_screen.dart';
import 'about_screen.dart';
import 'faq_screen.dart';
import 'profile_screen.dart';
import 'quizlist_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeView extends StatelessWidget {
  final User user;

  const HomeView({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      color: theme.scaffoldBackgroundColor,
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const SizedBox(height: 60),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Hi, ${user.name.split(' ').first}",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface,
                ),
              ),

              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ProfileScreen(user: user)),
                ),
                child: CircleAvatar(
                  radius: 26,
                  backgroundColor: theme.colorScheme.primary.withOpacity(0.2),
                  child: Icon(Icons.person_outline,
                      color: theme.colorScheme.primary, size: 28),
                ),
              ),
            ],
          ),


          const SizedBox(height: 20),

          // ⭐ APP ICON
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: const Icon(Icons.auto_awesome_outlined,
                color: Colors.white, size: 45),
          ),

          const SizedBox(height: 20),

          ShaderMask(
            shaderCallback: (bounds) =>
                const LinearGradient(colors: [
                  Color(0xFF8B5CF6),
                  Color(0xFFEC4899)
                ]).createShader(bounds),
            child: Text(
              'Quizzy',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white, // masked anyway
              ),
            ),
          ),

          const SizedBox(height: 6),

          Text(
            'Discover your personality today!',
            style: TextStyle(
              fontSize: 16,
              color: theme.textTheme.bodyMedium!.color!.withOpacity(0.6),
            ),
          ),

          const Spacer(),

          // ⭐ START QUIZ BUTTON
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => QuizListScreen(user: user),
                ),
              );
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding:
              const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
                ),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.purple.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.auto_awesome, color: Colors.white),
                  SizedBox(width: 10),
                  Text(
                    'Start Quiz',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const Spacer(),

          // ⭐ FEATURE CARDS
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildCard(
                context,
                icon: FontAwesomeIcons.bookOpen,
                label: 'Fun Facts',
                gradientColors: [Colors.blueAccent, Colors.cyan],
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const FunFactScreen()),
                ),
              ),
              buildCard(
                context,
                icon: Icons.help_outline,
                label: 'FAQ',
                gradientColors: [Colors.green, Colors.teal],
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => FAQScreen()),
                ),
              ),
              buildCard(
                context,
                icon: Icons.info_outline,
                label: 'About',
                gradientColors: [Colors.orangeAccent, Colors.pinkAccent],
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AboutScreen()),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
