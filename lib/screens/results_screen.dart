import 'package:flutter/material.dart';
import '../models/user_model.dart';
import 'home.dart';

class ResultScreen extends StatefulWidget {
  final int quizId;
  final Map<int, String> answers;
  final User user;

  const ResultScreen({
    super.key,
    required this.quizId,
    required this.answers,
    required this.user,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> with SingleTickerProviderStateMixin {
  int _userRating = 0;
  final TextEditingController _feedbackController = TextEditingController();
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _scaleAnimation = CurvedAnimation(parent: _controller, curve: Curves.elasticOut);
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final dominantLetter = _calculateDominantLetter();
    final resultData = _getPersonalityResult(widget.quizId, dominantLetter);

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
              child: SlideTransition(
                position: _slideAnimation,
                child: FadeTransition(
                  opacity: _controller,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(40),
                      boxShadow: [
                        BoxShadow(
                          color: theme.colorScheme.onSurface.withOpacity(
                            theme.brightness == Brightness.dark ? 0.25 : 0.15,
                          ),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ScaleTransition(
                            scale: _scaleAnimation,
                            child: Text(
                              resultData['emoji']!,
                              style: const TextStyle(fontSize: 80),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            "You are...",
                            style: TextStyle(
                              fontSize: 18,
                              color: theme.colorScheme.onSurface.withOpacity(0.6),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            resultData['title']!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            resultData['description']!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              height: 1.5,
                              color: theme.colorScheme.onSurface.withOpacity(0.7),
                            ),
                          ),
                          const SizedBox(height: 30),
                          Text(
                            "Rate this quiz:",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.onSurface.withOpacity(0.7),
                            ),
                          ),
                          const SizedBox(height: 8),
                          _buildRatingStars(theme),
                          const SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.surface.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: theme.colorScheme.onSurface.withOpacity(0.15),
                              ),
                            ),
                            child: TextField(
                              controller: _feedbackController,
                              maxLines: 3,
                              style: TextStyle(color: theme.colorScheme.onSurface),
                              decoration: InputDecoration(
                                hintText: "Tell us what you liked or disliked...",
                                hintStyle: TextStyle(
                                  color: theme.colorScheme.onSurface.withOpacity(0.5),
                                ),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.all(10),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeScreen(user: widget.user),
                                  ),
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
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingStars(ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return TweenAnimationBuilder(
          duration: const Duration(milliseconds: 300),
          tween: Tween<double>(begin: 1.0, end: index < _userRating ? 1.2 : 1.0),
          builder: (context, scale, child) {
            return Transform.scale(
              scale: scale,
              child: child,
            );
          },
          child: IconButton(
            onPressed: () {
              setState(() {
                _userRating = index + 1;
              });

              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("You rated it ${index + 1} stars!"),
                  duration: const Duration(milliseconds: 500),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            icon: Icon(
              index < _userRating ? Icons.star : Icons.star_border,
              color: Colors.amber,
              size: 32,
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        );
      }),
    );
  }

  String _calculateDominantLetter() {
    int a = 0, b = 0, c = 0, d = 0;

    widget.answers.values.forEach((v) {
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
        case 'a':
          return {
            'emoji': '📚',
            'title': 'The Intellectual',
            'description':
            'You value knowledge and peace. You handle conflicts calmly and love getting lost in a good book.'
          };
        case 'b':
          return {
            'emoji': '🦁',
            'title': 'The Bold Leader',
            'description':
            'You are outgoing, brave, and love taking charge. Challenges don\'t scare you; they fuel you.'
          };
        case 'c':
          return {
            'emoji': '🤝',
            'title': 'The Loyal Friend',
            'description':
            'Relationships are everything to you. You are supportive, kind, and the glue that holds your group together.'
          };
        case 'd':
          return {
            'emoji': '🎨',
            'title': 'The Creative Soul',
            'description':
            'You love trying new things and exploring the unknown. Routine bores you; adventure calls you.'
          };
      }
    }

    if (quizId == 2) {
      switch (letter) {
        case 'a':
          return {
            'emoji': '🎯',
            'title': 'The Achiever',
            'description':
            'You are driven by goals and results. You likely have a detailed plan for the next 5 years.'
          };
        case 'b':
          return {
            'emoji': '🌍',
            'title': 'The Explorer',
            'description':
            'You work to live, not live to work. You value experiences and freedom over strict routines.'
          };
        case 'c':
          return {
            'emoji': '🎓',
            'title': 'The Scholar',
            'description':
            'You are deeply analytical and love research. You handle criticism well because you want to improve.'
          };
        case 'd':
          return {
            'emoji': '🚀',
            'title': 'The Entrepreneur',
            'description':
            'You follow your passion. You likely prefer working on your own projects rather than a 9-to-5.'
          };
      }
    }

    if (quizId == 3) {
      switch (letter) {
        case 'a':
          return {
            'emoji': '🧘',
            'title': 'The Balanced Realist',
            'description':
            'You value stability, peace, and personal growth. You approach life with a calm mindset and handle stress thoughtfully.'
          };
        case 'b':
          return {
            'emoji': '✨',
            'title': 'The Passionate Dreamer',
            'description':
            'You follow your instincts and prioritize happiness. You love exploring and enjoying the moment.'
          };
        case 'c':
          return {
            'emoji': '❤️',
            'title': 'The Heartfelt Connector',
            'description':
            'Success to you is defined by the people you love. You cherish deep relationships and shared experiences.'
          };
        case 'd':
          return {
            'emoji': '🧠',
            'title': 'The Strategic Thinker',
            'description':
            'You are logical, goal-driven, and love learning. You tackle problems with a plan and strive for meaningful impact.'
          };
      }
    }

    return {
      'emoji': '✨',
      'title': 'Unique Spirit',
      'description':
      'You have a balanced personality with a mix of many great traits!'
    };
  }
}