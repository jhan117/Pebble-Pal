import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:graytalk/data/model/diary_model.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:graytalk/core/theme/colors.dart';
import 'package:graytalk/core/theme/fonts.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  late Future<List<DiaryModel>> _eventsForSelectedDate;

  @override
  void initState() {
    super.initState();
    _eventsForSelectedDate = _fetchEvents(_selectedDay);
  }

  Future<List<DiaryModel>> _fetchEvents(DateTime date) async {
    String formattedDate =
        '${date.year}${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}';

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('diaries')
        .where('date', isEqualTo: formattedDate)
        .get();

    return snapshot.docs.map(
      (QueryDocumentSnapshot e) {
        return DiaryModel.fromJson(json: e.data() as Map<String, dynamic>);
      },
    ).toList();
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
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
                _eventsForSelectedDate = _fetchEvents(_selectedDay);
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
                    "${_selectedDay.year}년 ${_selectedDay.month}월 ${_selectedDay.day}일",
                    style: titleLarge,
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: FutureBuilder<List<DiaryModel>>(
                      future: _eventsForSelectedDate,
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

                        final events = snapshot.data ?? [];
                        if (events.isEmpty) {
                          return const Center(child: Text('일기 없음'));
                        }

                        return ListView.builder(
                          itemCount: events.length,
                          itemBuilder: (context, index) =>
                              Text(events[index].content),
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
