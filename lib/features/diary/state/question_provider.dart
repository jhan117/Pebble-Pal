import 'dart:math';
import 'package:flutter/material.dart';
import 'package:graytalk/app/utils/diary_questions.dart';

class QuestionProvider extends ChangeNotifier {
  final List<String> _randomQuestions = [];
  late int _selectedIdx;

  List<String> get randomQuestions => _randomQuestions;
  int get selectedIdx => _selectedIdx;
  String get question => _randomQuestions[_selectedIdx];

  QuestionProvider() {
    _initializeQuestions();
    getRandQuestion();
  }

  void _initializeQuestions() {
    final shuffledQuestions = List.of(DiaryQuestions.questions)..shuffle();
    _randomQuestions.addAll(shuffledQuestions.take(3));
    notifyListeners();
  }

  void getRandQuestion() {
    _selectedIdx = Random().nextInt(_randomQuestions.length);
    notifyListeners();
  }

  void refreshQuestionAt([int? idx]) {
    idx ??= _selectedIdx;

    List<String> availableQuestions = DiaryQuestions.questions
        .where((q) => !_randomQuestions.contains(q))
        .toList();

    if (availableQuestions.isNotEmpty) {
      String newQuestion =
          availableQuestions[Random().nextInt(availableQuestions.length)];
      _randomQuestions[idx] = newQuestion;
      notifyListeners();
    }
  }

  String getByIdx(int idx) => _randomQuestions[idx];
}
