import 'package:flutter/material.dart';
import 'package:graytalk/app/theme/colors.dart';
import 'package:graytalk/app/theme/fonts.dart';
import 'package:graytalk/features/diary/data/diary_model.dart';
import 'package:graytalk/features/diary/data/diary_repository.dart';
import 'package:graytalk/features/diary/screen/diary_editor_screen.dart';

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
  final diaryRepo = DiaryRepository();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Diary>>(
      stream: diaryRepo.getByDate(widget.selectedDate),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text('일기 정보를 가져오지 못했습니다.'));
        }

        final diaries = snapshot.data ?? [];

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
                          questionText: diary.question,
                          initialContent: diary.content,
                          diaryId: diary.id,
                          isEditing: true,
                          selectedDate: diary.date,
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
      },
    );
  }
}
