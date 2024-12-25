import 'package:flutter/material.dart';
import 'package:graytalk/features/diary/widgets/calendar_widget.dart';
import 'package:graytalk/features/diary/widgets/diary_widget.dart';

class DiaryCalendarScreen extends StatefulWidget {
  const DiaryCalendarScreen({super.key});

  @override
  State<DiaryCalendarScreen> createState() => _DiaryCalendarScreenState();
}

class _DiaryCalendarScreenState extends State<DiaryCalendarScreen> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  _changeDay(selectedDay, focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CalendarWidget(
          selectedDate: _selectedDay,
          focusedDate: _focusedDay,
          changeDay: _changeDay,
        ),
        DiaryWidget(selectedDate: _selectedDay),
      ],
    );
  }
}
