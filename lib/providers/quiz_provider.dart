import 'package:flutter/material.dart';
import '../models/quiz_model.dart';
import '../database_helper.dart';
import '../models/question_model.dart';

class QuizProvider with ChangeNotifier {
  List<Quiz> _quizzes = [];
  bool _isLoading = false;

  List<Quiz> get quizzes => _quizzes;
  bool get isLoading => _isLoading;

  Future<void> loadQuizzes() async {
    _isLoading = true;
    notifyListeners();

    _quizzes = await DatabaseHelper.instance.getAllQuizzes();

    _isLoading = false;
    notifyListeners();
  }

  List<Question> _currentQuestions = [];
  List<Question> get currentQuestions => _currentQuestions;

  Future<void> loadQuestions(int quizId) async {
    _isLoading = true;

    _currentQuestions = await DatabaseHelper.instance.getQuestions(quizId);

    _isLoading = false;
    notifyListeners();
  }
}
