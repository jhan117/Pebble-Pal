class DiaryModel {
  final String id;
  final int questionIdx;
  final String content;
  final DateTime date;

  DiaryModel({
    required this.id,
    required this.questionIdx,
    required this.content,
    required this.date,
  });

  DiaryModel.fromJson({required Map<String, dynamic> json})
      : id = json['id'],
        questionIdx = json['questionIdx'],
        content = json['content'],
        date = DateTime.parse(json['date']);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'questionIdx': questionIdx,
      'content': content,
      'date':
          '${date.year}${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}',
    };
  }

  DiaryModel copyWith({
    String? id,
    int? questionIdx,
    String? content,
    DateTime? date,
  }) {
    return DiaryModel(
      id: id ?? this.id,
      questionIdx: questionIdx ?? this.questionIdx,
      content: content ?? this.content,
      date: date ?? this.date,
    );
  }
}
