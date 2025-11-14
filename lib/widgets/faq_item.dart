import 'dart:ui';
import 'package:flutter/material.dart';
import '../models/faq.dart';

class FAQItem extends StatefulWidget {
  final FAQ faq;
  final bool initiallyExpanded;

  const FAQItem({
    Key? key,
    required this.faq,
    this.initiallyExpanded = false,
  }) : super(key: key);

  @override
  State<FAQItem> createState() => _FAQItemState();
}

class _FAQItemState extends State<FAQItem> with TickerProviderStateMixin {
  bool _expanded = false;

  AnimationController? _arrowController;
  Animation<double>? _arrowAnim;

  @override
  void initState() {
    super.initState();

    _expanded = widget.initiallyExpanded;

    _arrowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );

    _arrowAnim = Tween<double>(
      begin: 0.0,
      end: 0.5,
    ).animate(
      CurvedAnimation(
        parent: _arrowController!,
        curve: Curves.easeInOut,
      ),
    );

    // if initially expanded, jump to end
    if (_expanded) _arrowController!.value = 1.0;
  }

  @override
  void dispose() {
    _arrowController?.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _expanded = !_expanded;
      if (_expanded) {
        _arrowController?.forward();
      } else {
        _arrowController?.reverse();
      }
    });
  }

  IconData _mapIcon(String name) {
    switch (name) {
      case 'shield':
        return Icons.shield_outlined;
      case 'clock':
        return Icons.access_time_outlined;
      case 'target':
        return Icons.adjust_outlined;
      case 'trending':
        return Icons.trending_up_outlined;
      default:
        return Icons.help_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final faq = widget.faq;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.82),
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              children: [
                GestureDetector(
                  onTap: _toggle,
                  child: Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    child: Row(
                      children: [
                        // gradient icon circle
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: faq.gradientColors
                                  .map((c) => Color(c))
                                  .toList(),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color(faq.gradientColors.first)
                                    .withOpacity(0.2),
                                blurRadius: 12,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Icon(
                              _mapIcon(faq.icon),
                              color: Colors.white,
                              size: 22,
                            ),
                          ),
                        ),

                        const SizedBox(width: 14),

                        Expanded(
                          child: Text(
                            faq.question,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1F2937),
                            ),
                          ),
                        ),

                        RotationTransition(
                          turns: _arrowAnim ?? AlwaysStoppedAnimation(0),
                          child: const Icon(
                            Icons.expand_more,
                            color: Color(0xFF9CA3AF),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // animated answer
                AnimatedSize(
                  duration: const Duration(milliseconds: 280),
                  curve: Curves.easeInOut,
                  child: ConstrainedBox(
                    constraints: _expanded
                        ? const BoxConstraints()
                        : const BoxConstraints(maxHeight: 0),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(86, 0, 16, 16),
                      child: Text(
                        faq.answer,
                        style: const TextStyle(
                          color: Color(0xFF4B5563),
                          height: 1.6,
                          fontSize: 14,
                        ),
                      ),
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
