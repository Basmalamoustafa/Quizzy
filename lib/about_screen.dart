import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  Widget _gradientIconCircle({required List<Color> colors, required Widget child}) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        shape: BoxShape.circle,
      ),
      child: Center(child: child),
    );
  }

  Widget _infoCard({
    required BuildContext context,
    required List<Color> iconGradient,
    required IconData icon,
    required String title,
    required String body,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.80),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.08),
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
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF111827),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  body,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
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

  Widget _socialCircle({required Widget icon, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha:0.12),
          shape: BoxShape.circle,

          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha:0.06),
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
    final headerGradient = const LinearGradient(
      colors: [Color(0xFF8B5CF6), Color(0xFFEC4899), Color(0xFF60A5FA)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
    final pinkBlue = const [Color(0xFFEC4899), Color(0xFF60A5FA)];
    final blueCyan = const [Color(0xFF60A5FA), Color(0xFF06B6D4)];
    final green = const [Color(0xFF34D399), Color(0xFF10B981)];

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
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
                        BoxShadow(
                          color: Colors.black.withValues(alpha:0.12),
                          blurRadius: 18,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Icon(
                        Icons.auto_awesome,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [Color(0xFF6D28D9), Color(0xFFEC4899)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                    blendMode: BlendMode.srcIn,
                    child: const Text(
                      'About Quizzy',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
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
                title: 'Our Mission',
                body:
                'We believe self-discovery is a journey worth celebrating. Quizzy helps you explore your unique personality traits through fun, science-backed quizzes.',
              ),

              _infoCard(
                context: context,
                iconGradient: blueCyan,
                icon: Icons.star,
                title: 'What We Do',
                body:
                "Our quizzes combine psychology research with engaging user experiences to help you better understand yourself and others. Whether you're curious about your strengths or looking to grow, we're here to guide you.",
              ),

              _infoCard(
                context: context,
                iconGradient: green,
                icon: Icons.group,
                title: 'The Team',
                body:
                "Created with passion by a team of psychologists, designers, and developers who love helping people discover their true selves.",
              ),

              const SizedBox(height: 12),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha:0.12),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      'Connect With Us',
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
                          icon: const FaIcon(FontAwesomeIcons.twitter, color: Colors.white, size: 18),
                          onTap: () {},
                        ),
                        const SizedBox(width: 12),
                        _socialCircle(
                          icon: const FaIcon(FontAwesomeIcons.linkedin, color: Colors.white, size: 18),
                          onTap: () {},
                        ),
                        const SizedBox(width: 12),
                        _socialCircle(
                          icon: const FaIcon(FontAwesomeIcons.github, color: Colors.white, size: 18),
                          onTap: () {},
                        ),
                        const SizedBox(width: 12),
                        _socialCircle(
                          icon: const Icon(Icons.mail_outline, color: Colors.white, size: 18),
                          onTap: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'hello@quizzy.app',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              Column(
                children: [
                  Text(
                    'Version 1.0.0',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Made with ❤️ for self-discovery',
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
