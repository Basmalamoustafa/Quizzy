import 'package:flutter/material.dart';
import '../models/faq.dart';
import '../widgets/faq_item.dart';

// FAQ page with common questions
class FAQScreen extends StatelessWidget {
  FAQScreen({Key? key}) : super(key: key);

  // List of frequently asked questions
  final List<FAQ> faqs = [
    FAQ(
      question: "How accurate are these quizzes?",
      answer:
      "Our personality quizzes are based on established psychological frameworks. They're insightful but not clinical assessments.",
      icon: "help",
      gradientColors: [0xFF9F7AEA, 0xFF7C3AED],
    ),
    FAQ(
      question: "Is my data private and secure?",
      answer:
      "Yes! Your quiz responses never leave your device. You may clear your data anytime.",
      icon: "shield",
      gradientColors: [0xFF60A5FA, 0xFF06B6D4],
    ),
    FAQ(
      question: "How long does the quiz take?",
      answer:
      "Most quizzes take 5–10 minutes—simple, fast, and insightful!",
      icon: "clock",
      gradientColors: [0xFF34D399, 0xFF10B981],
    ),
    FAQ(
      question: "Can I retake the quiz?",
      answer:
      "Absolutely! Retake quizzes anytime. Results may shift as you grow.",
      icon: "target",
      gradientColors: [0xFFFB923C, 0xFFEC4899],
    ),
    FAQ(
      question: "Will my personality type change?",
      answer:
      "Yes. Personality traits evolve through major life stages and experiences.",
      icon: "trending",
      gradientColors: [0xFFB794F4, 0xFF7C3AED],
    ),
  ];

  // Title with gradient text effect
  Widget _gradientTitle(String title) {
    return ShaderMask(
      shaderCallback: (bounds) =>
          const LinearGradient(
            colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
          ).createShader(bounds),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 32,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // header
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Column(
                children: [
                  _gradientTitle("FAQ"),
                  const SizedBox(height: 8),
                  Text(
                    "Frequently Asked Questions",
                    style: TextStyle(
                      fontSize: 14,
                      color: isDark ? Colors.grey[300] : const Color(0xFF6B7280),
                    ),
                  ),
                  const SizedBox(height: 18),
                ],
              ),
            ),

            // list
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 18, top: 6),
                itemCount: faqs.length + 1,
                itemBuilder: (context, index) {
                  if (index < faqs.length) {
                    return FAQItem(faq: faqs[index]);
                  }

                  // CTA block
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 22),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFAE6DF9), Color(0xFFEC4899)],
                        ),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Still have questions?",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              "We're here to help! Reach out anytime.",
                              style: TextStyle(color: Colors.white70),
                            ),
                            const SizedBox(height: 12),
                            Align(
                              alignment: Alignment.centerRight,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black87,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(28),
                                  ),
                                ),
                                child: const Text("Contact Support"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
