import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// About page showing app info and details
class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  // Creates a circular icon with gradient background
  Widget _gradientIconCircle({
    required List<Color> colors,
    required Widget child,
  }) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: colors),
        shape: BoxShape.circle,
      ),
      child: Center(child: child),
    );
  }

  // Card showing mission
  Widget _infoCard({
    required BuildContext context,
    required List<Color> iconGradient,
    required IconData icon,
    required String title,
    required String body,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withOpacity(0.06)
            : Colors.white.withOpacity(0.90),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _gradientIconCircle(
            colors: iconGradient,
            child: Icon(icon, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : const Color(0xFF111827),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  body,
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark ? Colors.grey[300] : Colors.grey[700],
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Social media icon button
  Widget _socialCircle({
    required Widget icon,
    required bool isDark,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: isDark
              ? Colors.white.withOpacity(0.10)
              : Colors.white.withOpacity(0.20),
          shape: BoxShape.circle,
          boxShadow: [
            if (!isDark)
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 6,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Center(child: icon),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final headerGradient = const LinearGradient(
      colors: [Color(0xFF8B5CF6), Color(0xFFEC4899), Color(0xFF60A5FA)],
    );

    final pinkBlue = const [Color(0xFFEC4899), Color(0xFF60A5FA)];
    final blueCyan = const [Color(0xFF60A5FA), Color(0xFF06B6D4)];
    final green = const [Color(0xFF34D399), Color(0xFF10B981)];

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Column(
                children: [
                  Container(
                    width: 96,
                    height: 96,
                    decoration: BoxDecoration(
                      gradient: headerGradient,
                      shape: BoxShape.circle,
                      boxShadow: [
                        if (!isDark)
                          BoxShadow(
                            color: Colors.black.withOpacity(0.12),
                            blurRadius: 18,
                            offset: const Offset(0, 8),
                          ),
                      ],
                    ),
                    child: const Center(
                      child: Icon(Icons.auto_awesome,
                          color: Colors.white, size: 40),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [Color(0xFF6D28D9), Color(0xFFEC4899)],
                    ).createShader(bounds),
                    blendMode: BlendMode.srcIn,
                    child: Text(
                      "About Quizzy",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _infoCard(
                context: context,
                iconGradient: pinkBlue,
                icon: Icons.favorite,
                title: "Our Mission",
                body:
                    "We believe self-discovery is a journey worth celebrating. Quizzy helps you explore your unique personality traits through fun, science-backed quizzes.",
              ),
              _infoCard(
                context: context,
                iconGradient: blueCyan,
                icon: Icons.star,
                title: "What We Do",
                body:
                    "Our quizzes combine psychology research with engaging experiences to help you understand yourself better.",
              ),
              _infoCard(
                context: context,
                iconGradient: green,
                icon: Icons.group,
                title: "The Team",
                body:
                    "Created with passion by a team of psychologists, designers, and developers who love helping people grow.",
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    if (!isDark)
                      BoxShadow(
                        color: Colors.black.withOpacity(0.12),
                        blurRadius: 18,
                        offset: const Offset(0, 8),
                      ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      "Connect With Us",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _socialCircle(
                          icon: const FaIcon(FontAwesomeIcons.twitter,
                              color: Colors.white),
                          isDark: isDark,
                        ),
                        const SizedBox(width: 12),
                        _socialCircle(
                          icon: const FaIcon(FontAwesomeIcons.linkedin,
                              color: Colors.white),
                          isDark: isDark,
                        ),
                        const SizedBox(width: 12),
                        _socialCircle(
                          icon: const FaIcon(FontAwesomeIcons.github,
                              color: Colors.white),
                          isDark: isDark,
                        ),
                        const SizedBox(width: 12),
                        _socialCircle(
                          icon: const Icon(Icons.mail_outline,
                              color: Colors.white),
                          isDark: isDark,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "hello@quizzy.app",
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Version 1.0.0",
                style: TextStyle(
                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Made with ❤️ for self-discovery",
                style: TextStyle(
                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
