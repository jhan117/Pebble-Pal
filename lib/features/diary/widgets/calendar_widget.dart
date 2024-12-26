import 'package:flutter/material.dart';
import 'package:graytalk/app/styles/app_colors.dart';
import 'package:graytalk/features/diary/data/diary_model.dart';
import 'package:graytalk/features/diary/state/diary_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatefulWidget {
  final DateTime selectedDay;
  final DateTime focusedDay;
  final void Function(DateTime, DateTime) changeDay;

  const CalendarWidget({
    super.key,
    required this.selectedDay,
    required this.focusedDay,
    required this.changeDay,
  });

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  CalendarFormat _calendarFormat = CalendarFormat.month;

  void _toggleCalendarFormat() {
    setState(() {
      _calendarFormat = _calendarFormat == CalendarFormat.month
          ? CalendarFormat.week
          : CalendarFormat.month;
    });
  }

  List<Diary> _getDiaryForDay(DateTime day) {
    return context.watch<DiaryProvider>().getByDay(day.day);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: const BoxDecoration(
          border: Border(
        bottom: BorderSide(color: Colors.black),
      )),
      child: TableCalendar(
        locale: 'ko_KR',
        firstDay: DateTime.utc(2000, 1, 1),
        lastDay: DateTime.utc(2100, 12, 31),
        focusedDay: widget.focusedDay,
        onDaySelected: (selectedDay, focusedDay) {
          if (selectedDay.month != focusedDay.month) {
            widget.changeDay(selectedDay, selectedDay);
          } else {
            widget.changeDay(selectedDay, focusedDay);
          }
        },
        selectedDayPredicate: (day) => isSameDay(widget.selectedDay, day),
        calendarFormat: _calendarFormat,
        onHeaderTapped: (focusedDay) {
          _toggleCalendarFormat();
        },
        onPageChanged: (focusedDay) {
          widget.changeDay(focusedDay, focusedDay);
        },
        eventLoader: _getDiaryForDay,
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: theme.textTheme.bodyLarge!,
          titleTextFormatter: (date, locale) =>
              DateFormat('yyyy-MM-dd EEE', locale).format(
            widget.selectedDay,
          ),
        ),
        calendarStyle: CalendarStyle(
            todayTextStyle: const TextStyle(color: AppColors.primaryColor),
            todayDecoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
              shape: BoxShape.circle,
            ),
            selectedDecoration: const BoxDecoration(
              color: AppColors.primaryColor,
              shape: BoxShape.circle,
            ),
            // marker style
            markersMaxCount: 1,
            markerSize: 5,
            markersAnchor: 1.5,
            markerDecoration: const BoxDecoration(
              color: AppColors.secondaryColor,
              shape: BoxShape.circle,
            )),
      ),
    );
  }
}
