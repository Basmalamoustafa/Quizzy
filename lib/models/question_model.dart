class Question {
  final int? id;
  final int quizId;
  final int number;
  final String questionText;
  final String optionA;
  final String optionB;
  final String optionC;
  final String optionD;

  Question({
    this.id,
    required this.quizId,
    required this.number,
    required this.questionText,
    required this.optionA,
    required this.optionB,
    required this.optionC,
    required this.optionD,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'quizId': quizId,
      'number': number,
      'questionText': questionText,
      'a': optionA,
      'b': optionB,
      'c': optionC,
      'd': optionD,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      id: map['id'],
      quizId: map['quizId'],
      number: map['number'],
      questionText: map['questionText'],
      optionA: map['a'],
      optionB: map['b'],
      optionC: map['c'],
      optionD: map['d'],
    );
  }
}
