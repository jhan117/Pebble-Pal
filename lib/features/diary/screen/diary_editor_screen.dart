import 'package:flutter/material.dart';
import 'package:graytalk/features/diary/data/diary_model.dart';
import 'package:graytalk/features/diary/data/diary_repository.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import 'package:graytalk/features/diary/widgets/question_card.dart';

class DiaryEditorScreen extends StatefulWidget {
  final int? questionIndex;
  final String questionText;
  final String? diaryId;
  final String? initialContent;
  final bool isEditing;
  final DateTime? selectedDate;

  const DiaryEditorScreen({
    super.key,
    this.questionIndex,
    required this.questionText,
    this.diaryId,
    this.initialContent,
    this.isEditing = false,
    this.selectedDate,
  });

  @override
  State<DiaryEditorScreen> createState() => _DiaryEditorScreenState();
}

class _DiaryEditorScreenState extends State<DiaryEditorScreen> {
  final TextEditingController _textController = TextEditingController();
  late final String _formattedDate;
  final DiaryRepository _diaryRepository = DiaryRepository();

  @override
  void initState() {
    super.initState();
    _formattedDate = DateFormat('yyyy년 MM월 dd일')
        .format(widget.selectedDate ?? DateTime.now());
    if (widget.initialContent != null) {
      _textController.text = widget.initialContent!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(_formattedDate, style: textTheme.titleLarge),
        centerTitle: true,
        leading: const SizedBox(),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          QuestionCard(
            index: widget.questionIndex,
            question: widget.questionText,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _textController,
                autofocus: true,
                maxLines: null,
                textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "글을 입력해 주세요",
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (widget.isEditing)
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.black),
                  onPressed: _handleDelete,
                ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.check, color: Colors.black),
                onPressed: _handleSave,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _handleSave() async {
    final content = _textController.text;

    if (content.isEmpty) {
      await _handleDelete();
      return;
    }

    if (widget.isEditing) {
      await _updateDiary(content);
    } else {
      await _createDiary(content);
    }

    _navigateBack();
  }

  Future<void> _handleDelete() async {
    if (widget.diaryId != null) {
      await _diaryRepository.delete(widget.diaryId!);
    }
    _navigateBack();
  }

  Future<void> _createDiary(String content) async {
    final newDiary = Diary(
      id: const Uuid().v4(),
      question: widget.questionText,
      content: content,
      date: DateTime.now(),
    );
    await _diaryRepository.add(newDiary);
  }

  Future<void> _updateDiary(String content) async {
    final updatedDiary = Diary(
      id: widget.diaryId!,
      question: widget.questionText,
      content: content,
      date: widget.selectedDate!,
    );
    await _diaryRepository.update(updatedDiary);
  }

  void _navigateBack() {
    if (mounted) {
      Navigator.of(context).pop();
    }
  }
}
