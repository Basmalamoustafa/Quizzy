class FAQ {
  final String question;
  final String answer;
  final String icon; // simple icon key; map to Material icons in widget
  final List<int> gradientColors; // ARGB ints for gradient

  FAQ({
    required this.question,
    required this.answer,
    this.icon = 'help',
    this.gradientColors = const [0xFF7C4DFF, 0xFF4F46E5],
  });
}
