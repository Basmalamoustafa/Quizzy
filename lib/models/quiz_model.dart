class Quiz {
  final int? id;
  final String title;
  final String description;
  final String estimatedTime;
  final String ageRange;
  final String imagePath;

  Quiz({
    this.id,
    required this.title,
    required this.description,
    required this.estimatedTime,
    required this.ageRange,
    required this.imagePath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'estimatedTime': estimatedTime,
      'ageRange': ageRange,
      'imagePath': imagePath,
    };
  }

  factory Quiz.fromMap(Map<String, dynamic> map) {
    return Quiz(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      estimatedTime: map['estimatedTime'],
      ageRange: map['ageRange'],
      imagePath: map['imagePath'],
    );
  }
}
