import 'package:flutter/material.dart';
import 'package:graytalk/presentation/state/question_provider.dart';
import 'package:graytalk/presentation/widgets/question_box.dart';
import 'package:provider/provider.dart';

class DiaryScreen extends StatelessWidget {
  const DiaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final questionProvider = context.watch<QuestionProvider>();
    final questions = questionProvider.randomQuestions;

    return Wrap(
      spacing: 0,
      runSpacing: 32,
      alignment: WrapAlignment.center,
      runAlignment: WrapAlignment.center,
      children: List.generate(
        questions.length,
        (idx) => QuestionBox(
          questionIdx: idx,
          questionText: questions[idx],
          onRefresh: () => questionProvider.refreshQuestionAt(idx),
        ),
      ),
    );
  }
}
