import 'package:flutter/material.dart';
import 'package:graytalk/features/diary/data/diary_repository.dart';
import 'package:graytalk/features/diary/widgets/calendar_widget.dart';
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
        DiaryWidget(selectedDate: _selectedDate),
      ],
    );
  }
}
