import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:graytalk/app/theme/fonts.dart';

class CalendarWidget extends StatefulWidget {
  final DateTime selectedDate;
  final DateTime focusedDate;
  final void Function(DateTime, DateTime) onDaySelected;

  const CalendarWidget({
    super.key,
    required this.selectedDate,
    required this.focusedDate,
    required this.onDaySelected,
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
          widget.onDaySelected(selectedDay, focusedDay);
        },
        selectedDayPredicate: (day) => isSameDay(widget.focusedDate, day),
        calendarFormat: _calendarFormat,
        onHeaderTapped: (focusedDay) {
          _toggleCalendarFormat();
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
