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

  late AnimationController _arrowController;
  late Animation<double> _arrowAnim;

  @override
  void initState() {
    super.initState();

    _expanded = widget.initiallyExpanded;

    _arrowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );

    _arrowAnim = Tween<double>(begin: 0, end: 0.5).animate(
      CurvedAnimation(parent: _arrowController, curve: Curves.easeInOut),
    );

    if (_expanded) _arrowController.value = 1.0;
  }

  @override
  void dispose() {
    _arrowController.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _expanded = !_expanded;
      _expanded ? _arrowController.forward() : _arrowController.reverse();
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
    final theme = Theme.of(context);
    final surface = theme.colorScheme.surface;
    final onSurface = theme.colorScheme.onSurface;

    final faq = widget.faq;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            decoration: BoxDecoration(
              color: surface.withOpacity(0.85),
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(
                    theme.brightness == Brightness.dark ? 0.40 : 0.12,
                  ),
                  blurRadius: 18,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              children: [
                GestureDetector(
                  onTap: _toggle,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    child: Row(
                      children: [
                        // Gradient circle
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: faq.gradientColors.map((c) => Color(c)).toList(),
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(_mapIcon(faq.icon), color: Colors.white),
                        ),

                        const SizedBox(width: 14),

                        Expanded(
                          child: Text(
                            faq.question,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: onSurface,
                            ),
                          ),
                        ),

                        RotationTransition(
                          turns: _arrowAnim,
                          child: Icon(
                            Icons.expand_more,
                            color: onSurface.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                AnimatedSize(
                  duration: const Duration(milliseconds: 280),
                  child: ConstrainedBox(
                    constraints: _expanded
                        ? const BoxConstraints()
                        : const BoxConstraints(maxHeight: 0),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                      child: Text(
                        faq.answer,
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.5,
                          color: onSurface.withOpacity(0.7),
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
