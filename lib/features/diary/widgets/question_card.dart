import 'package:flutter/material.dart';
import 'package:graytalk/features/diary/screen/diary_editor_screen.dart';
import 'package:graytalk/features/diary/state/question_provider.dart';
import 'package:provider/provider.dart';

class QuestionCard extends StatelessWidget {
  final bool isEdit;
  final int? idx;
  final String? diaryQuestion;
  final EdgeInsetsGeometry margin;

  const QuestionCard({
    super.key,
    this.isEdit = false,
    this.idx,
    this.diaryQuestion,
    required this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final questionProvider = context.watch<QuestionProvider>();

    final question = (idx != null)
        ? questionProvider.getByIdx(idx!)
        : questionProvider.question;

    void handlePress() {
      if (!isEdit) {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DiaryEditorScreen(
            questionIndex: idx ?? questionProvider.selectedIdx,
            questionText: question,
          ),
        ));
      }
    }

    return Container(
      margin: margin,
      child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: 140,
            child: ElevatedButton(
              onPressed: isEdit ? null : handlePress,
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 16)),
              child: Text(
                diaryQuestion ?? question,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          if (!isEdit)
            Positioned(
              top: 2,
              right: 2,
              child: IconButton(
                icon: const Icon(Icons.refresh),
                iconSize: 32,
                onPressed: () {
                  questionProvider.refreshQuestionAt(idx);
                },
              ),
            ),
        ],
      ),
    );
  }
}
