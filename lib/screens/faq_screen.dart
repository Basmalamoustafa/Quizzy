import 'package:flutter/material.dart';
import '../models/faq.dart';
import '../widgets/faq_item.dart';

class FAQScreen extends StatelessWidget {
  FAQScreen({Key? key}) : super(key: key);

  // replicate the JS/Tailwind list (icon keys and gradient class equivalents)
  final List<FAQ> faqs = [
    FAQ(
      question: "How accurate are these quizzes?",
      answer:
      "Our personality quizzes are based on established psychological frameworks and research. While they provide valuable insights, they should be viewed as fun, educational tools rather than clinical assessments.",
      icon: "help",
      gradientColors: [0xFF9F7AEA, 0xFF7C3AED], // purple -> indigo
    ),
    FAQ(
      question: "Is my data private and secure?",
      answer:
      "Yes! We take your privacy seriously. Your quiz responses are stored locally on your device and are never shared with third parties. You can clear your data anytime.",
      icon: "shield",
      gradientColors: [0xFF60A5FA, 0xFF06B6D4], // blue -> cyan
    ),
    FAQ(
      question: "How long does the quiz take?",
      answer:
      "Most quizzes take between 5-10 minutes to complete. We've designed them to be quick yet insightful, perfect for a coffee break or commute.",
      icon: "clock",
      gradientColors: [0xFF34D399, 0xFF10B981], // green -> emerald
    ),
    FAQ(
      question: "Can I retake the quiz?",
      answer:
      "Absolutely! You can retake any quiz as many times as you'd like. Personalities can evolve over time, so your results might change as you grow.",
      icon: "target",
      gradientColors: [0xFFFB923C, 0xFFEC4899], // orange -> pink
    ),
    FAQ(
      question: "Will my personality type change over time?",
      answer:
      "Yes, research shows that personality traits can shift throughout your life, especially during major life transitions. Retaking quizzes periodically can help you track these changes.",
      icon: "trending",
      gradientColors: [0xFFB794F4, 0xFF7C3AED], // violet -> purple
    ),
  ];

  // gradient text helper (like bg-clip-text)
  Widget _gradientTitle(String text) {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 32,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.6,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // similar background to your Figma (soft pink tint)
      backgroundColor: const Color(0xFFFBF6FB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const SizedBox.shrink(),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // header
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Column(
                children: [
                  // gradient "FAQ"
                  _gradientTitle('FAQ'),
                  const SizedBox(height: 8),
                  const Text(
                    'Frequently Asked Questions',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                  const SizedBox(height: 18),
                ],
              ),
            ),

            // list
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 18.0, top: 6.0),
                physics: const BouncingScrollPhysics(),
                itemCount: faqs.length + 1,
                itemBuilder: (context, index) {
                  if (index < faqs.length) {
                    return FAQItem(faq: faqs[index]);
                  }

                  // CTA bottom card
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 22.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFAE6DF9), Color(0xFFEC4899)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.purple.withOpacity(0.18),
                              blurRadius: 24,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Still have questions?',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
                              ),
                              const SizedBox(height: 6),
                              const Text(
                                "We're here to help! Reach out to our support team.",
                                style: TextStyle(color: Colors.white70),
                              ),
                              const SizedBox(height: 12),
                              Align(
                                alignment: Alignment.centerRight,
                                child: ElevatedButton(
                                  onPressed: () {
                                    // TODO: wire contact support
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                  ),
                                  child: const Text('Contact Support', style: TextStyle(color: Colors.black87)),
                                ),
                              )
                            ],
                          ),
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
