import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/buildcard.dart';
import 'package:flutter_application_1/pages/fun_fact_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_application_1/pages/about_screen.dart';
import 'package:flutter_application_1/pages/faq_screen.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const SizedBox(height: 80),
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
                shaderCallback: (bounds) => const LinearGradient(
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
              const Text(
                'Discover your personality today!',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
          const Spacer(),

          GestureDetector(
            onTap: () {},
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding:
                  const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
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
                mainAxisAlignment: MainAxisAlignment.center,
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
          const Spacer(),

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
                  MaterialPageRoute(builder: (context) => FunFactScreen())
                ),
              ),
              buildCard(
                context,
                icon: Icons.help_outline,
                label: 'FAQ',
                gradientColors: [Colors.green, Colors.teal],
                onTap: ()=>Navigator.push(
                    context,MaterialPageRoute(builder:(context)=>FAQScreen())) ,
              ),
              buildCard(
                context,
                icon: Icons.info_outline,
                label: 'About',
                gradientColors: [Colors.orangeAccent, Colors.pinkAccent],
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutScreen())
                )
              ),

            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}