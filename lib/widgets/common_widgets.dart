import 'package:flutter/material.dart';

class GradientHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const GradientHeader({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        const SizedBox(height: 24),

        ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) => LinearGradient(
            colors: [
              theme.colorScheme.primary,
              theme.colorScheme.secondary,
            ],
          ).createShader(bounds),
          child: Text(
            title,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),

        const SizedBox(height: 8),

        Text(
          subtitle,
          style: TextStyle(
            fontSize: 16,
            color: theme.colorScheme.onBackground.withOpacity(0.7),
          ),
        ),
      ],
    );
  }
}

class ContentCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const ContentCard({
    Key? key,
    required this.child,
    this.padding = const EdgeInsets.all(24),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withOpacity(0.90),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.onSurface.withOpacity(0.12),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: child,
    );
  }
}

class GradientActionButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onTap;

  const GradientActionButton({
    Key? key,
    required this.text,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              theme.colorScheme.primary,
              theme.colorScheme.secondary,
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.primary.withOpacity(0.4),
              blurRadius: 14,
              offset: const Offset(0, 5),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 8),
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PaginationDots extends StatelessWidget {
  final int totalCount;
  final int currentIndex;
  final Function(int) onDotTap;
  final int maxVisibleDots;

  const PaginationDots({
    Key? key,
    required this.totalCount,
    required this.currentIndex,
    required this.onDotTap,
    this.maxVisibleDots = 10, // ⭐ limit dots to 10
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (totalCount == 0) return const SizedBox.shrink();

    // ⭐ Visible dots limited to maxVisibleDots
    final int visibleCount =
    totalCount > maxVisibleDots ? maxVisibleDots : totalCount;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int index = 0; index < visibleCount; index++)
          GestureDetector(
            onTap: () => onDotTap(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 8,
              width: index == currentIndex ? 32 : 8,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                gradient: index == currentIndex
                    ? const LinearGradient(
                  colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
                )
                    : null,
                color: index == currentIndex
                    ? null
                    : Colors.grey.withOpacity(0.3),
              ),
            ),
          ),


      ],
    );
  }
}


