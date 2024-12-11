import 'package:flutter/material.dart';
import 'package:graytalk/app/theme/colors.dart';
import 'package:graytalk/app/theme/fonts.dart';
import 'package:graytalk/features/diary/data/diary_model.dart';
import 'package:graytalk/features/diary/data/diary_repository.dart';
import 'package:graytalk/features/diary/screen/diary_editor_screen.dart';

class DiaryWidget extends StatefulWidget {
  final List<String> splitText;
  final Diary diary;
  final String questionText;
  final DateTime selectedDate;

  const DiaryWidget({
    super.key,
    required this.splitText,
    required this.diary,
    required this.questionText,
    required this.selectedDate,
  });

  @override
  State<DiaryWidget> createState() => _DiaryWidgetState();
}

class _DiaryWidgetState extends State<DiaryWidget> {
  final diaryRepo = DiaryRepository();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 100,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.splitText[0],
                  style: textTheme.bodyMedium,
                ),
                if (widget.splitText.length > 1)
                  Text(
                    widget.splitText[1],
                    style: textTheme.bodyMedium,
                  ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () async {
              final result = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DiaryEditorScreen(
                    questionText: widget.questionText,
                    initialContent: widget.diary.content,
                    diaryId: widget.diary.id,
                    isEditing: true,
                    selectedDate: widget.selectedDate,
                  ),
                ),
              );

              if (result != null && result == '') {
                await diaryRepo.delete(widget.diary.id);
              }
            },
            child: Container(
              width: double.infinity,
              height: 150,
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: ListView(
                children: [
                  Text(
                    widget.diary.content,
                    style: textTheme.bodyMedium,
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
