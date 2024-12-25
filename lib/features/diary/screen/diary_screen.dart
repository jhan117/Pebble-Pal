import 'package:flutter/material.dart';
import 'package:graytalk/features/diary/state/question_provider.dart';
import 'package:graytalk/features/diary/widgets/question_card.dart';
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
        (idx) => QuestionCard(
          index: idx,
          question: questions[idx],
          onRefresh: () => questionProvider.refreshQuestionAt(idx),
        ),
      ),
    );
  }
}
