import 'package:flutter/material.dart';
import 'package:graytalk/features/diary/state/diary_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:graytalk/app/theme/fonts.dart';

class CalendarWidget extends StatefulWidget {
  final DateTime selectedDate;
  final DateTime focusedDate;
  final void Function(DateTime, DateTime) changeDay;

  const CalendarWidget({
    super.key,
    required this.selectedDate,
    required this.focusedDate,
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

  @override
  void initState() {
    super.initState();
    context.read<DiaryProvider>().getByMonth(
          DateTime.now().year,
          DateTime.now().month,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(
        bottom: BorderSide(color: Colors.black),
      )),
      child: TableCalendar(
        locale: 'ko_KR',
        firstDay: DateTime.utc(2000, 1, 1),
        lastDay: DateTime.utc(2100, 12, 31),
        focusedDay: widget.focusedDate,
        onDaySelected: (selectedDay, focusedDay) {
          widget.changeDay(selectedDay, focusedDay);
        },
        selectedDayPredicate: (day) => isSameDay(widget.focusedDate, day),
        calendarFormat: _calendarFormat,
        onHeaderTapped: (focusedDay) {
          _toggleCalendarFormat();
        },
        onPageChanged: (focusedDay) {
          context
              .read<DiaryProvider>()
              .getByMonth(focusedDay.year, focusedDay.month);

          final selectedDay = DateTime(
              focusedDay.year, focusedDay.month, widget.selectedDate.day);
          widget.changeDay(selectedDay, selectedDay);
        },
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: bodyLarge,
          titleTextFormatter: (date, locale) =>
              DateFormat('yyyy-MM-dd EEE', locale).format(
            widget.selectedDate,
          ),
        ),
        calendarStyle: CalendarStyle(
          todayTextStyle: bodyMedium,
          todayDecoration: const BoxDecoration(
            color: Color.fromARGB(255, 223, 152, 152),
            shape: BoxShape.circle,
          ),
          selectedDecoration: const BoxDecoration(
            color: Colors.pinkAccent,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
