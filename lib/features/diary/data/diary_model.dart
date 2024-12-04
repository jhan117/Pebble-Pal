import 'package:intl/intl.dart';

class Diary {
  final String id;
  final String question;
  final String content;
  final DateTime date;

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
      date: DateTime.parse(json['date'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    final dateFormat = DateFormat('yyyyMMdd');
    return {
      'id': id,
      'question': question,
      'content': content,
      'date': dateFormat.format(date),
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
