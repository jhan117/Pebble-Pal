import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:graytalk/data/model/diary_model.dart';
import 'package:graytalk/presentation/pages/diary_editor_screen.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:graytalk/core/theme/colors.dart';
import 'package:graytalk/core/theme/fonts.dart';

class DiaryCalendar extends StatefulWidget {
  const DiaryCalendar({super.key});

  @override
  State<DiaryCalendar> createState() => _DiaryCalendarState();
}

class _DiaryCalendarState extends State<DiaryCalendar> {
  DateTime _selectedDate = DateTime.now();
  DateTime _focusedDate = DateTime.now();

  Stream<List<Diary>> _loadDiariesForDate(DateTime date) {
    final formattedDate =
        '${date.year}${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}';
    return FirebaseFirestore.instance
        .collection('diaries')
        .where('date', isEqualTo: formattedDate)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Diary.fromJson(doc.data())).toList();
    });
  }

  Future<void> _removeDiary(String diaryId) async {
    await FirebaseFirestore.instance
        .collection('diaries')
        .doc(diaryId)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TableCalendar(
            locale: 'ko_KR',
            firstDay: DateTime.utc(2000, 1, 1),
            lastDay: DateTime.utc(2100, 12, 31),
            focusedDay: _focusedDate,
            selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDate = selectedDay;
                _focusedDate = focusedDay;
              });
            },
            calendarFormat: CalendarFormat.month,
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle: headlineMedium,
            ),
            calendarStyle: const CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Color.fromARGB(255, 223, 152, 152),
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.pinkAccent,
                shape: BoxShape.circle,
              ),
              outsideDaysVisible: false,
            ),
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
                      stream: _loadDiariesForDate(_selectedDate),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        if (snapshot.hasError) {
                          return const Center(
                              child: Text('일기 정보를 가져오지 못했습니다.'));
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

                            return Column(
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
                                    final result =
                                        await Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => DiaryEditorScreen(
                                          questionText: questionText,
                                          initialContent: diary.content,
                                          diaryId: diary.id,
                                          isEditing: true,
                                          selectedDate: _selectedDate,
                                        ),
                                      ),
                                    );

                                    if (result != null && result == '') {
                                      await _removeDiary(diary.id);
                                    }
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: 100,
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8),
                                    color: Colors.transparent,
                                    child: Text(
                                      diary.content,
                                      style: textTheme.bodyMedium,
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 1,
                                  color: Colors.grey,
                                ),
                                const SizedBox(height: 16),
                              ],
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
      ),
    );
  }
}
