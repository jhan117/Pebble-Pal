import 'dart:math';
import 'package:flutter/material.dart';
import 'package:graytalk/core/utils/diary_questions.dart';

class QuestionProvider extends ChangeNotifier {
  final List<String> _randomQuestions = [];

  QuestionProvider() {
    _initializeQuestions(3);
  }

  void _initializeQuestions(int count) {
    final shuffledQuestions = List.of(DiaryQuestions.questions)..shuffle();
    _randomQuestions.addAll(shuffledQuestions.take(3));
    debugPrint('Initialized questions: $_randomQuestions');
    notifyListeners();
  }

  void refreshQuestionAt(int index) {
    List<String> availableQuestions = DiaryQuestions.questions
        .where((q) => !_randomQuestions.contains(q))
        .toList();

    if (availableQuestions.isNotEmpty) {
      String newQuestion =
          availableQuestions[Random().nextInt(availableQuestions.length)];
      _randomQuestions[index] = newQuestion;
      debugPrint('Refreshed question at index $index: $newQuestion');
      notifyListeners();
    }
  }

  List<String> get randomQuestions => _randomQuestions;
}
