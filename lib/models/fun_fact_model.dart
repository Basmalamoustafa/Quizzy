import 'package:flutter/material.dart';

class FunFact {
  final IconData icon;
  final List<Color> gradientColors;
  final String fact;
  final String title;
  final String category;

  const FunFact({
    required this.icon,
    required this.gradientColors,
    required this.fact,
    required this.title,
    required this.category,
  });
}

const List<String> mbtiTypes = [
  'All', 'INTJ', 'INTP', 'ENTJ', 'ENTP', 'INFJ', 'INFP', 'ENFJ', 'ENFP',
  'ISTJ', 'ISFJ', 'ESTJ', 'ESFJ', 'ISTP', 'ISFP', 'ESTP', 'ESFP'
];

class AppGradients {
  static const c1 = [Color(0xFFC084FC), Color(0xFF818CF8)];
  static const c2 = [Color(0xFFF472B6), Color(0xFFF43F5E)];
  static const c3 = [Color(0xFFFACC15), Color(0xFFF97316)];
  static const c4 = [Color(0xFF38BDF8), Color(0xFF06B6D4)];
  static const c5 = [Color(0xFF4ADE80), Color(0xFF10B981)];
  static const c6 = [Color(0xFF8B5CF6), Color(0xFF6366F1)];
  
  static const intj = [Color(0xFF6366F1), Color(0xFF8B5CF6)];
  static const intp = [Color(0xFF06B6D4), Color(0xFF3B82F6)];
  static const entj = [Color(0xFFEF4444), Color(0xFFF97316)];
  static const entp = [Color(0xFF22C55E), Color(0xFF14B8A6)];
  static const infj = [Color(0xFFD946EF), Color(0xFFEC4899)];
  static const infp = [Color(0xFF60A5FA), Color(0xFF8B5CF6)];
  static const enfj = [Color(0xFFEC4899), Color(0xFFF43F5E)];
  static const enfp = [Color(0xFFF97316), Color(0xFFFACC15)];
  static const istj = [Color(0xFF6B7280), Color(0xFF4B5563)];
  static const isfj = [Color(0xFF2DD4BF), Color(0xFF06B6D4)];
  static const estj = [Color(0xFFF87171), Color(0xFFF97316)];
  static const esfj = [Color(0xFFF472B6), Color(0xFFEF4444)];
  static const istp = [Color(0xFF71717A), Color(0xFF52525B)];
  static const isfp = [Color(0xFF34D399), Color(0xFF22C55E)];
  static const estp = [Color(0xFFF59E0B), Color(0xFFEAB308)];
  static const esfp = [Color(0xFFD946EF), Color(0xFFEC4899)];
}

final List<FunFact> allFunFacts = [
  // INTJ Facts
  FunFact(
    icon: Icons.psychology_outlined,
    gradientColors: AppGradients.intj,
    fact: "INTJs are known as 'The Architects' and make up only 2% of the population. They're strategic masterminds who love long-term planning.",
    title: "INTJ - The Architect",
    category: 'INTJ',
  ),
  FunFact(
    icon: Icons.lightbulb_outline,
    gradientColors: AppGradients.intj,
    fact: "INTJs often have a highly developed intuition and can see patterns and connections that others miss, making them excellent strategists.",
    title: "INTJ Strategic Mind",
    category: 'INTJ',
  ),
  
  // INTP Facts
  FunFact(
    icon: Icons.psychology_outlined,
    gradientColors: AppGradients.intp,
    fact: "INTPs are 'The Logicians' who love theoretical concepts and abstract thinking. They question everything and seek logical explanations.",
    title: "INTP - The Logician",
    category: 'INTP',
  ),
  FunFact(
    icon: Icons.lightbulb_outline,
    gradientColors: AppGradients.intp,
    fact: "INTPs are known for their incredible problem-solving abilities and often come up with innovative solutions to complex problems.",
    title: "INTP Innovation",
    category: 'INTP',
  ),
  
  // ENTJ Facts
  FunFact(
    icon: Icons.psychology_outlined,
    gradientColors: AppGradients.entj,
    fact: "ENTJs are 'The Commanders' - natural-born leaders who are confident, decisive, and love organizing people and resources efficiently.",
    title: "ENTJ - The Commander",
    category: 'ENTJ',
  ),
  FunFact(
    icon: Icons.lightbulb_outline,
    gradientColors: AppGradients.entj,
    fact: "ENTJs are highly ambitious and driven. They often rise to leadership positions and make up about 3% of the population.",
    title: "ENTJ Leadership",
    category: 'ENTJ',
  ),
  
  // ENTP Facts
  FunFact(
    icon: Icons.lightbulb_outline,
    gradientColors: AppGradients.entp,
    fact: "ENTPs are 'The Debaters' who love intellectual challenges and playing devil's advocate. They're quick-witted and highly creative.",
    title: "ENTP - The Debater",
    category: 'ENTP',
  ),
  FunFact(
    icon: Icons.psychology_outlined,
    gradientColors: AppGradients.entp,
    fact: "ENTPs are excellent at brainstorming and can see multiple perspectives on any issue, making them great innovators.",
    title: "ENTP Innovation",
    category: 'ENTP',
  ),
  
  // INFJ Facts
  FunFact(
    icon: Icons.favorite_border,
    gradientColors: AppGradients.infj,
    fact: "INFJs are 'The Advocates' and the rarest personality type, making up less than 1% of the population. They're deeply idealistic and empathetic.",
    title: "INFJ - The Advocate",
    category: 'INFJ',
  ),
  FunFact(
    icon: Icons.psychology_outlined,
    gradientColors: AppGradients.infj,
    fact: "INFJs have an uncanny ability to understand others' emotions and motivations, often knowing what someone needs before they do.",
    title: "INFJ Intuition",
    category: 'INFJ',
  ),

  // INFP Facts
  FunFact(
    icon: Icons.favorite_border,
    gradientColors: AppGradients.infp,
    fact: "INFPs are 'The Mediators' - idealistic dreamers guided by their values and morals. They're creative, empathetic, and deeply individualistic.",
    title: "INFP - The Mediator",
    category: 'INFP',
  ),
  FunFact(
    icon: Icons.lightbulb_outline,
    gradientColors: AppGradients.infp,
    fact: "INFPs are often drawn to creative pursuits and have a rich inner world. They make up about 4% of the population.",
    title: "INFP Creativity",
    category: 'INFP',
  ),
  
  // ENFJ Facts
  FunFact(
    icon: Icons.favorite_border,
    gradientColors: AppGradients.enfj,
    fact: "ENFJs are 'The Protagonists' - charismatic leaders who inspire others and are deeply concerned with helping people reach their potential.",
    title: "ENFJ - The Protagonist",
    category: 'ENFJ',
  ),
  FunFact(
    icon: Icons.psychology_outlined,
    gradientColors: AppGradients.enfj,
    fact: "ENFJs have exceptional people skills and can read emotional atmospheres instantly, making them natural counselors and teachers.",
    title: "ENFJ Empathy",
    category: 'ENFJ',
  ),
  
  // ENFP Facts
  FunFact(
    icon: Icons.lightbulb_outline,
    gradientColors: AppGradients.enfp,
    fact: "ENFPs are 'The Campaigners' - enthusiastic, creative free spirits who live life with passion and excitement. They love connecting with others!",
    title: "ENFP - The Campaigner",
    category: 'ENFP',
  ),
  FunFact(
    icon: Icons.favorite_border,
    gradientColors: AppGradients.enfp,
    fact: "ENFPs are incredibly spontaneous and adaptable, thriving on new experiences and possibilities. They make up about 7% of the population.",
    title: "ENFP Spontaneity",
    category: 'ENFP',
  ),
  
  // --- Sentinel Group ---

  // ISTJ Facts
  FunFact(
    icon: Icons.psychology_outlined,
    gradientColors: AppGradients.istj,
    fact: "ISTJs are 'The Logisticians' - reliable, practical, and fact-oriented. They value tradition and are known for their incredible dependability.",
    title: "ISTJ - The Logistician",
    category: 'ISTJ',
  ),
  FunFact(
    icon: Icons.lightbulb_outline,
    gradientColors: AppGradients.istj,
    fact: "ISTJs are one of the most common personality types, representing about 13% of the population. They excel at organizing and managing details.",
    title: "ISTJ Reliability",
    category: 'ISTJ',
  ),
  
  // ISFJ Facts
  FunFact(
    icon: Icons.favorite_border,
    gradientColors: AppGradients.isfj,
    fact: "ISFJs are 'The Defenders' - warm, caring protectors who are dedicated to supporting and caring for others. They're incredibly loyal.",
    title: "ISFJ - The Defender",
    category: 'ISFJ',
  ),
  FunFact(
    icon: Icons.psychology_outlined,
    gradientColors: AppGradients.isfj,
    fact: "ISFJs have excellent memories for details about people they care about and are often the glue that holds families and teams together.",
    title: "ISFJ Dedication",
    category: 'ISFJ',
  ),
  
  // ESTJ Facts
  FunFact(
    icon: Icons.psychology_outlined,
    gradientColors: AppGradients.estj,
    fact: "ESTJs are 'The Executives' - organized, traditional leaders who believe in rules, structure, and getting things done efficiently.",
    title: "ESTJ - The Executive",
    category: 'ESTJ',
  ),
  FunFact(
    icon: Icons.lightbulb_outline,
    gradientColors: AppGradients.estj,
    fact: "ESTJs are natural administrators who excel at managing projects and people. They make up about 11% of the population.",
    title: "ESTJ Organization",
    category: 'ESTJ',
  ),
  
  // ESFJ Facts
  FunFact(
    icon: Icons.favorite_border,
    gradientColors: AppGradients.esfj,
    fact: "ESFJs are 'The Consuls' - social butterflies who thrive on harmony and helping others. They're warm, outgoing, and incredibly supportive.",
    title: "ESFJ - The Consul",
    category: 'ESFJ',
  ),
  FunFact(
    icon: Icons.psychology_outlined,
    gradientColors: AppGradients.esfj,
    fact: "ESFJs are highly attuned to others' needs and emotions, making them excellent caregivers and community builders.",
    title: "ESFJ Caring",
    category: 'ESFJ',
  ),
  
  // --- Explorer Group ---

  // ISTP Facts
  FunFact(
    icon: Icons.lightbulb_outline,
    gradientColors: AppGradients.istp,
    fact: "ISTPs are 'The Virtuosos' - practical experimenters who love understanding how things work. They're hands-on problem solvers.",
    title: "ISTP - The Virtuoso",
    category: 'ISTP',
  ),
  FunFact(
    icon: Icons.psychology_outlined,
    gradientColors: AppGradients.istp,
    fact: "ISTPs are calm in crisis situations and excel at troubleshooting. They're often drawn to mechanics, sports, and crafts.",
    title: "ISTP Problem-Solving",
    category: 'ISTP',
  ),

  // ISFP Facts
  FunFact(
    icon: Icons.favorite_border,
    gradientColors: AppGradients.isfp,
    fact: "ISFPs are 'The Adventurers' - artistic, sensitive souls who live in the present moment and express themselves through creative means.",
    title: "ISFP - The Adventurer",
    category: 'ISFP',
  ),
  FunFact(
    icon: Icons.lightbulb_outline,
    gradientColors: AppGradients.isfp,
    fact: "ISFPs have a strong appreciation for beauty and aesthetics. They're often talented artists, musicians, or designers.",
    title: "ISFP Artistry",
    category: 'ISFP',
  ),
  
  // ESTP Facts
  FunFact(
    icon: Icons.lightbulb_outline,
    gradientColors: AppGradients.estp,
    fact: "ESTPs are 'The Entrepreneurs' - energetic risk-takers who live for action and excitement. They're bold, perceptive, and love being in the spotlight.",
    title: "ESTP - The Entrepreneur",
    category: 'ESTP',
  ),
  FunFact(
    icon: Icons.psychology_outlined,
    gradientColors: AppGradients.estp,
    fact: "ESTPs are excellent at reading people and situations quickly, making them great negotiators and salespeople.",
    title: "ESTP Adaptability",
    category: 'ESTP',
  ),
  
  // ESFP Facts
  FunFact(
    icon: Icons.favorite_border,
    gradientColors: AppGradients.esfp,
    fact: "ESFPs are 'The Entertainers' - spontaneous, enthusiastic performers who love bringing joy to others. Life is a party for ESFPs!",
    title: "ESFP - The Entertainer",
    category: 'ESFP',
  ),
  FunFact(
    icon: Icons.lightbulb_outline,
    gradientColors: AppGradients.esfp,
    fact: "ESFPs are highly observant and live fully in the moment. They're often the life of the party and natural performers.",
    title: "ESFP Energy",
    category: 'ESFP',
  ),
  FunFact(
    icon: Icons.psychology_outlined,
    gradientColors: AppGradients.c1,
    fact: "Your personality is about 40-60% influenced by genetics, with the rest shaped by experiences and environment.",
    title: "Nature vs Nurture",
    category: 'All',
  ),
  FunFact(
    icon: Icons.favorite_border,
    gradientColors: AppGradients.c2,
    fact: "People who smile more often are perceived as more likeable, courteous, and competent by others.",
    title: "The Power of Smiling",
    category: 'All',
  ),
  FunFact(
    icon: Icons.lightbulb_outline,
    gradientColors: AppGradients.c3,
    fact: "Introverts and extroverts actually process rewards differently in their brains, which explains their different social preferences.",
    title: "Brain Chemistry",
    category: 'All',
  ),
  FunFact(
    icon: Icons.psychology_outlined,
    gradientColors: AppGradients.c4,
    fact: "The average person makes about 35,000 decisions each day. Decision fatigue is real!",
    title: "Decision Making",
    category: 'All',
  ),
  FunFact(
    icon: Icons.favorite_border,
    gradientColors: AppGradients.c5,
    fact: "Studies show that writing about your feelings can improve your mental and physical health.",
    title: "Emotional Expression",
    category: 'All',
  ),
  FunFact(
    icon: Icons.lightbulb_outline,
    gradientColors: AppGradients.c6,
    fact: "Your personality can change over time! Research shows people tend to become more agreeable and conscientious as they age.",
    title: "Personality Evolution",
    category: 'All',
  )
];