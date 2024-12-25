import 'package:flutter/material.dart';
import 'package:graytalk/features/diary/state/diary_provider.dart';
import 'package:graytalk/features/diary/widgets/calendar_widget.dart';
import 'package:graytalk/features/diary/widgets/diary_widget.dart';
import 'package:provider/provider.dart';

class DiaryCalendarScreen extends StatefulWidget {
  const DiaryCalendarScreen({super.key});

  @override
  State<DiaryCalendarScreen> createState() => _DiaryCalendarScreenState();
}

class _DiaryCalendarScreenState extends State<DiaryCalendarScreen> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  _changeDay(DateTime selectedDay, DateTime focusedDay) {
    final diaryProvider = context.read<DiaryProvider>();

    if (focusedDay.month != diaryProvider.getDay.month) {
      diaryProvider.getByMonth(focusedDay.year, focusedDay.month);
    }

    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
    });
  }

  @override
  void initState() {
    super.initState();
    context
        .read<DiaryProvider>()
        .getByMonth(_selectedDay.year, _selectedDay.month);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CalendarWidget(
          selectedDay: _selectedDay,
          focusedDay: _focusedDay,
          changeDay: _changeDay,
        ),
        DiaryWidget(selectedDate: _selectedDay),
      ],
    );
  }
}
