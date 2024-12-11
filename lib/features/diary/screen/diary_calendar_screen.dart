import 'package:flutter/material.dart';
import 'package:graytalk/app/theme/fonts.dart';
import 'package:graytalk/features/diary/data/diary_repository.dart';
import 'package:graytalk/features/diary/widgets/calendar_widget.dart';
import 'package:graytalk/features/diary/data/diary_model.dart';
import 'package:graytalk/app/theme/colors.dart';
import 'package:graytalk/features/diary/widgets/diary_widget.dart';

class DiaryCalendarScreen extends StatefulWidget {
  const DiaryCalendarScreen({super.key});

  @override
  State<DiaryCalendarScreen> createState() => _DiaryCalendarScreenState();
}

class _DiaryCalendarScreenState extends State<DiaryCalendarScreen> {
  DateTime _selectedDate = DateTime.now();
  DateTime _focusedDate = DateTime.now();
  final diaryRepo = DiaryRepository();

  _onDaySelected(selectedDay, focusedDay) {
    setState(() {
      _selectedDate = selectedDay;
      _focusedDate = focusedDay;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CalendarWidget(
          selectedDate: _selectedDate,
          focusedDate: _focusedDate,
          onDaySelected: _onDaySelected,
        ),
        const SizedBox(height: 10),
        Expanded(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${_selectedDate.year}년 ${_selectedDate.month}월 ${_selectedDate.day}일",
                  style: titleLarge,
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: StreamBuilder<List<Diary>>(
                    stream: diaryRepo.getByDate(_selectedDate),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasError) {
                        return const Center(child: Text('일기 정보를 가져오지 못했습니다.'));
                      }

                      final diaries = snapshot.data ?? [];
                      if (diaries.isEmpty) {
                        return const Center(child: Text('일기 없음'));
                      }

                      return ListView.builder(
                        itemCount: diaries.length,
                        itemBuilder: (context, index) {
                          final diary = diaries[index];
                          final questionText = diary.question;
                          final splitText = questionText.split('\n');

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: DiaryWidget(
                              splitText: splitText,
                              diary: diary,
                              questionText: questionText,
                              selectedDate: _selectedDate,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
