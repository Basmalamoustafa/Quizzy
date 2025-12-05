import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/user_model.dart';
import 'fun_fact_screen.dart';
import 'faq_screen.dart';
import 'about_screen.dart';
import 'profile_screen.dart';

class HomeView extends StatelessWidget {
  final User user;

  const HomeView({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      // ⭐ Full-page theme background (dark/light)
      color: theme.scaffoldBackgroundColor,

      child: SingleChildScrollView(
        child: Container(
          // ⭐ Fixes the “¾ dark / ¼ light” issue
          width: double.infinity,
          color: theme.scaffoldBackgroundColor,

          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 8),

                // ⭐ small top-right profile avatar
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProfileScreen(user: user),
                          ),
                        );
                      },
                      child: CircleAvatar(
                        radius: 22,
                        backgroundColor:
                        isDark ? Colors.white12 : Colors.purple.shade100,
                        backgroundImage: user.profileImagePath != null &&
                            user.profileImagePath!.isNotEmpty
                            ? FileImage(File(user.profileImagePath!))
                            : null,
                        child: (user.profileImagePath == null ||
                            user.profileImagePath!.isEmpty)
                            ? Icon(
                          Icons.person,
                          color: isDark ? Colors.white : Colors.white,
                        )
                            : null,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // ⭐ Center logo + title
                Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.auto_awesome_outlined,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ShaderMask(
                      shaderCallback: (bounds) =>
                          const LinearGradient(
                            colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
                          ).createShader(bounds),
                      child: const Text(
                        'Quizzy',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Discover your personality today!',
                      style: TextStyle(
                        fontSize: 16,
                        color: isDark ? Colors.grey[300] : Colors.grey,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 50),

                // ⭐ Start quiz button
                GestureDetector(
                  onTap: () {},
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 60, vertical: 20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color:
                          Colors.purple.withOpacity(isDark ? 0.2 : 0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.auto_awesome, color: Colors.white, size: 24),
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

                const SizedBox(height: 50),

                // ⭐ Cards row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _homeCard(
                      context,
                      icon: FontAwesomeIcons.bookOpen,
                      label: 'Fun Facts',
                      colors: [Colors.blueAccent, Colors.cyan],
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FunFactScreen()),
                      ),
                    ),
                    _homeCard(
                      context,
                      icon: Icons.help_outline,
                      label: 'FAQ',
                      colors: [Colors.green, Colors.teal],
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FAQScreen()),
                      ),
                    ),
                    _homeCard(
                      context,
                      icon: Icons.info_outline,
                      label: 'About',
                      colors: [Colors.orangeAccent, Colors.pinkAccent],
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AboutScreen()),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ⭐ Reusable card builder
  Widget _homeCard(
      BuildContext context, {
        required IconData icon,
        required String label,
        required List<Color> colors,
        required VoidCallback onTap,
      }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 90,
        height: 90,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: colors),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: colors.first.withOpacity(isDark ? 0.15 : 0.4),
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 26),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
