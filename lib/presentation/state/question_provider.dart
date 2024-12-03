import 'dart:math';
import 'package:flutter/material.dart';
import 'package:graytalk/core/utils/diary_questions.dart';

class QuestionProvider extends ChangeNotifier {
  final random = Random();
  final List<String> _randomQuestions = [];
  late int _selectedIdx;

  QuestionProvider() {
    _initializeQuestions(3);
    getRandQuestion();
  }

  void _initializeQuestions(int count) {
    final shuffledQuestions = List.of(DiaryQuestions.questions)..shuffle();
    _randomQuestions.addAll(shuffledQuestions.take(3));
    notifyListeners();
  }

  void refreshQuestionAt(int index) {
    List<String> availableQuestions = DiaryQuestions.questions
        .where((q) => !_randomQuestions.contains(q))
        .toList();

    if (availableQuestions.isNotEmpty) {
      String newQuestion =
          availableQuestions[random.nextInt(availableQuestions.length)];
      _randomQuestions[index] = newQuestion;
      notifyListeners();
    }
  }

  void getRandQuestion() {
    _selectedIdx = random.nextInt(_randomQuestions.length);
    notifyListeners();
  }

  String getByIdx([int? idx]) {
    idx ??= _selectedIdx;
    return _randomQuestions[idx];
  }

  List<String> get randomQuestions => _randomQuestions;
  int get selectedIdx => _selectedIdx;
}
