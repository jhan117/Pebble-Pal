import 'package:flutter/material.dart';
import 'package:graytalk/features/diary/screen/diary_editor_screen.dart';
import 'package:graytalk/app/theme/colors.dart';

class QuestionCard extends StatelessWidget {
  final int? index;
  final String question;
  final VoidCallback? onRefresh;

  const QuestionCard({
    super.key,
    this.index,
    required this.question,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    List<String> questionParts = question.split('\n');

    return GestureDetector(
      onTap: () {
        if (onRefresh != null) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DiaryEditorScreen(
              questionIndex: index,
              questionText: question,
            ),
          ));
        }
      },
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 140,
            margin: const EdgeInsets.symmetric(horizontal: 32),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  questionParts[0],
                  style: textTheme.bodyMedium,
                ),
                if (questionParts.length > 1)
                  Text(
                    questionParts[1],
                    style: textTheme.bodyMedium,
                  ),
              ],
            ),
          ),
          if (onRefresh != null)
            Positioned(
              top: 4,
              right: 36,
              child: IconButton(
                icon: const Icon(Icons.refresh),
                iconSize: 32,
                onPressed: onRefresh,
              ),
            ),
        ],
      ),
    );
  }
}
