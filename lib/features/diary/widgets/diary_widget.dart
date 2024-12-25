import 'package:flutter/material.dart';
import 'package:graytalk/app/theme/colors.dart';
import 'package:graytalk/app/theme/fonts.dart';
import 'package:graytalk/features/diary/screen/diary_editor_screen.dart';
import 'package:graytalk/features/diary/state/diary_provider.dart';
import 'package:provider/provider.dart';

class DiaryWidget extends StatefulWidget {
  final DateTime selectedDate;

  const DiaryWidget({
    super.key,
    required this.selectedDate,
  });

  @override
  State<DiaryWidget> createState() => _DiaryWidgetState();
}

class _DiaryWidgetState extends State<DiaryWidget> {
  @override
  Widget build(BuildContext context) {
    final diaries =
        context.watch<DiaryProvider>().getByDay(widget.selectedDate.day);

    if (diaries.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(
          "작성된 글이 없습니다.",
          style: bodyMedium,
        ),
      );
    }

    return Expanded(
      child: ListView.builder(
        itemCount: diaries.length,
        itemBuilder: (context, index) {
          final diary = diaries[index];

          return Column(
            children: [
              Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainer,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...diary.question
                        .split('\n')
                        .map((q) => Text(q, style: textTheme.bodyMedium))
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DiaryEditorScreen(
                      isEditing: true,
                      diary: diary,
                    ),
                  ));
                },
                child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      diary.content,
                      style: bodyMedium,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
