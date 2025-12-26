import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../models/question_model.dart';
import '../models/user_model.dart';
import 'results_screen.dart';

// Screen showing quiz questions one at a time
class QuestionScreen extends StatefulWidget {
  final int quizId;
  final String quizTitle;
  final User user;

  const QuestionScreen({
    super.key,
    required this.quizId,
    required this.quizTitle,
    required this.user,
  });

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  int _currentIndex = 0; // Current question number
  final Map<int, String> _answers = {}; // Stores answers by question index

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<QuizProvider>(context, listen: false)
          .loadQuestions(widget.quizId);
    });
  }

  // Saves answer and moves to next question or shows results
  void _submitAnswer(String answerKey) {
    setState(() {
      _answers[_currentIndex] = answerKey;
    });

    Future.delayed(const Duration(milliseconds: 300), () {
      final provider = Provider.of<QuizProvider>(context, listen: false);

      if (_currentIndex < provider.currentQuestions.length - 1) {
        setState(() {
          _currentIndex++;
        });
      } else {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 800),
            pageBuilder: (_, __, ___) => ResultScreen(
              quizId: widget.quizId,
              answers: _answers,
              user: widget.user,
            ),
            transitionsBuilder: (_, animation, __, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Consumer<QuizProvider>(
            builder: (context, provider, child) {
              if (provider.isLoading) {
                return const Center(
                    child: CircularProgressIndicator(color: Colors.white));
              }

              if (provider.currentQuestions.isEmpty) {
                return const Center(
                  child: Text("No questions found",
                      style: TextStyle(color: Colors.white)),
                );
              }

              final question = provider.currentQuestions[_currentIndex];
              final totalQuestions = provider.currentQuestions.length;

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.close, color: Colors.white),
                        ),
                        Expanded(
                          child: Text(
                            "Question ${_currentIndex + 1}/$totalQuestions",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 48),
                      ],
                    ),
                  ),
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      transitionBuilder: (Widget child, Animation<double> animation) {
                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(1, 0),
                            end: Offset.zero,
                          ).animate(animation),
                          child: child,
                        );
                      },
                      child: Container(
                        key: ValueKey<int>(_currentIndex),
                        width: double.infinity,
                        margin: const EdgeInsets.all(16),
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            )
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              question.questionText,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: 40),
                            _buildOption(question, 'a', question.optionA, 0),
                            _buildOption(question, 'b', question.optionB, 1),
                            _buildOption(question, 'c', question.optionC, 2),
                            _buildOption(question, 'd', question.optionD, 3),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  // Builds an answer option button
  Widget _buildOption(Question q, String key, String text, int index) {
    final theme = Theme.of(context);
    bool isSelected = _answers[_currentIndex] == key;

    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 400),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, double value, child) {
        return Transform.translate(
          offset: Offset(0, 20 * (1 - value)),
          child: Opacity(opacity: value, child: child),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: isSelected ? Matrix4.identity().scaled(0.98) : Matrix4.identity(),
          child: ElevatedButton(
            onPressed: () => _submitAnswer(key),
            style: ElevatedButton.styleFrom(
              backgroundColor: isSelected ? const Color(0xFFEC4899) : theme.colorScheme.surface,
              foregroundColor: isSelected ? Colors.white : theme.colorScheme.onSurface,
              elevation: isSelected ? 0 : 2,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: BorderSide(
                  color: isSelected ? Colors.transparent : theme.colorScheme.onSurface.withOpacity(0.08),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 15,
                  backgroundColor: isSelected
                      ? Colors.white.withOpacity(0.3)
                      : theme.colorScheme.onSurface.withOpacity(0.12),
                  child: Text(
                    key.toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: isSelected ? Colors.white : theme.colorScheme.onSurface,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: 16,
                      color: isSelected ? Colors.white : theme.colorScheme.onSurface,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}