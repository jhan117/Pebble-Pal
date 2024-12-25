import 'package:flutter/material.dart';
import 'package:graytalk/features/diary/data/diary_model.dart';
import 'package:graytalk/features/diary/state/diary_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import 'package:graytalk/features/diary/widgets/question_card.dart';

class DiaryEditorScreen extends StatefulWidget {
  final bool isEditing;
  final int? questionIndex;
  final String? questionText;
  final Diary? diary;

  const DiaryEditorScreen({
    super.key,
    this.isEditing = false,
    this.questionIndex,
    this.questionText,
    this.diary,
  });

  @override
  State<DiaryEditorScreen> createState() => _DiaryEditorScreenState();
}

class _DiaryEditorScreenState extends State<DiaryEditorScreen> {
  final TextEditingController _textController = TextEditingController();
  late final String _formattedDate;
  late final DiaryProvider _diaryProvider;

  @override
  void initState() {
    super.initState();
    DateFormat titleFormat = DateFormat("yyyy년 MM월 dd일");
    _diaryProvider = context.read<DiaryProvider>();

    if (widget.isEditing) {
      _formattedDate = titleFormat.format(widget.diary!.date);
      _textController.text = widget.diary!.content;
    } else {
      _formattedDate = titleFormat.format(DateTime.now());
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
            question: widget.questionText ?? widget.diary!.question,
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

  // save button
  Future<void> _handleSave() async {
    final content = _textController.text;

    if (content.isEmpty) {
      await _handleDelete();
      return;
    }

    if (widget.isEditing) {
      await _diaryProvider.updateDiary(widget.diary!, content);
    } else {
      final newDiary = Diary(
        id: const Uuid().v4(),
        question: widget.diary!.question,
        content: content,
        date: DateTime.now(),
      );
      await _diaryProvider.addDiary(newDiary);
    }

    _navigateBack();
  }

  // delete button
  Future<void> _handleDelete() async {
    await _diaryProvider.deleteDiary(widget.diary!);
    _navigateBack();
  }

  void _navigateBack() {
    if (mounted) {
      Navigator.of(context).pop();
    }
  }
}
