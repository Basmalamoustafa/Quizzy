import 'package:flutter/material.dart';
import 'home.dart';

class ResultScreen extends StatelessWidget {
  final int quizId;
  final Map<int, String> answers;

  const ResultScreen({
    super.key,
    required this.quizId,
    required this.answers,
  });

  @override
  Widget build(BuildContext context) {
    final dominantLetter = _calculateDominantLetter();
    final resultData = _getPersonalityResult(quizId, dominantLetter);

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 80),

            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 20,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      resultData['emoji']!,
                      style: const TextStyle(fontSize: 80),
                    ),
                    const SizedBox(height: 24),

                    Text(
                      "You are...",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),

                    Text(
                      resultData['title']!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF8B5CF6),
                      ),
                    ),
                    const SizedBox(height: 24),

                    Text(
                      resultData['description']!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        height: 1.5,
                      ),
                    ),

                    const Spacer(),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => const HomeScreen()),
                                (route) => false,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: const Color(0xFFEC4899),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          "Back to Home",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  String _calculateDominantLetter() {
    int a = 0, b = 0, c = 0, d = 0;

    answers.values.forEach((v) {
      if (v == 'a') a++;
      if (v == 'b') b++;
      if (v == 'c') c++;
      if (v == 'd') d++;
    });

    int max = [a, b, c, d].reduce((curr, next) => curr > next ? curr : next);

    if (max == a) return 'a';
    if (max == b) return 'b';
    if (max == c) return 'c';
    return 'd';
  }

  Map<String, String> _getPersonalityResult(int quizId, String letter) {

    if (quizId == 1) {
      switch (letter) {
        case 'a': return {'emoji': '📚', 'title': 'The Intellectual', 'description': 'You value knowledge and peace. You handle conflicts calmly and love getting lost in a good book.'};
        case 'b': return {'emoji': '🦁', 'title': 'The Bold Leader', 'description': 'You are outgoing, brave, and love taking charge. Challenges don\'t scare you; they fuel you.'};
        case 'c': return {'emoji': '🤝', 'title': 'The Loyal Friend', 'description': 'Relationships are everything to you. You are supportive, kind, and the glue that holds your group together.'};
        case 'd': return {'emoji': '🎨', 'title': 'The Creative Soul', 'description': 'You love trying new things and exploring the unknown. Routine bores you; adventure calls you.'};
      }
    }

    if (quizId == 2) {
      switch (letter) {
        case 'a': return {'emoji': '🎯', 'title': 'The Achiever', 'description': 'You are driven by goals and results. You likely have a detailed plan for the next 5 years.'};
        case 'b': return {'emoji': '🌍', 'title': 'The Explorer', 'description': 'You work to live, not live to work. You value experiences and freedom over strict routines.'};
        case 'c': return {'emoji': '🎓', 'title': 'The Scholar', 'description': 'You are deeply analytical and love research. You handle criticism well because you want to improve.'};
        case 'd': return {'emoji': '🚀', 'title': 'The Entrepreneur', 'description': 'You follow your passion. You likely prefer working on your own projects rather than a 9-to-5.'};
      }
    }

    if (quizId == 3) {
      switch (letter) {
        case 'a': return {'emoji': '🧘', 'title': 'The Balanced Realist', 'description': 'You value stability, peace, and personal growth. You approach life with a calm, practical mindset and handle stress by taking care of yourself.'};
        case 'b': return {'emoji': '✨', 'title': 'The Passionate Dreamer', 'description': 'You follow your instincts and prioritize happiness. You aren\'t afraid to dream big, explore new places, and enjoy the beauty of the moment.'};
        case 'c': return {'emoji': '❤️', 'title': 'The Heartfelt Connector', 'description': 'Success to you is defined by the people you love. You are deeply supportive, cherish your relationships, and find joy in shared experiences.'};
        case 'd': return {'emoji': '🧠', 'title': 'The Strategic Thinker', 'description': 'You are logical, goal-oriented, and love learning. You tackle problems head-on with a plan and constantly strive to build a meaningful legacy.'};
      }
    }

    return {'emoji': '✨', 'title': 'Unique Spirit', 'description': 'You have a balanced personality with a mix of many great traits!'};
  }
}
