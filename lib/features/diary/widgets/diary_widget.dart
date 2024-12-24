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
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: StreamBuilder<List<Diary>>(
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
              return Stack(
                children: [
                  CustomPaint(
                    painter: LinedBackgroundPainter(lineHeight: 24.0),
                    size: Size.infinite,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12, right: 12),
                    child: Text(
                      '작성된 글이 없습니다.',
                      style: bodyMedium,
                    ),
                  ),
                ],
              );
            }

            return ListView.builder(
              itemCount: diaries.length,
              itemBuilder: (context, index) {
                final diary = diaries[index];
                final questionText = diary.question;
                final splitText = questionText.split('\n');

                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.only(bottom: 16),
                  margin: const EdgeInsets.all(16),
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
                              splitText[0],
                              style: textTheme.bodyMedium,
                            ),
                            if (splitText.length > 1)
                              Text(
                                splitText[1],
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
                                questionText: questionText,
                                initialContent: diary.content,
                                diaryId: diary.id,
                                isEditing: true,
                                selectedDate: widget.selectedDate,
                              ),
                            ),
                          );

                          if (result != null && result == '') {
                            await diaryRepo.delete(diary.id);
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          height: 150,
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: ListView(
                            children: [
                              Text(
                                diary.content,
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
              },
            );
          },
        ),
      ),
    );
  }
}

class LinedBackgroundPainter extends CustomPainter {
  final double lineHeight;

  LinedBackgroundPainter({
    required this.lineHeight,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.shade400
      ..strokeWidth = 1.0;

    for (double y = 0; y < size.height; y += lineHeight) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
