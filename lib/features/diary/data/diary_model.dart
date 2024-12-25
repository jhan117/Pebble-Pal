import 'package:intl/intl.dart';

class Diary {
  final String id;
  final String question;
  final String content;
  final DateTime date;

  int get year => date.year;
  int get month => date.month;

  Diary({
    required this.id,
    required this.question,
    required this.content,
    required this.date,
  });

  factory Diary.fromJson(Map<String, dynamic> json) {
    return Diary(
      id: json['id'] as String,
      question: json['question'] as String,
      content: json['content'] as String,
      date: DateFormat('yyyy MM dd').parse(json['date'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'content': content,
      'date': DateFormat('yyyy MM dd').format(date),
      'year': year,
      'month': month,
    };
  }

  Diary clone({
    String? id,
    String? question,
    String? content,
    DateTime? date,
  }) {
    return Diary(
      id: id ?? this.id,
      question: question ?? this.question,
      content: content ?? this.content,
      date: date ?? this.date,
    );
  }
}
