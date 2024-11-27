import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:graytalk/data/model/diary_model.dart';
import 'package:graytalk/presentation/state/question_provider.dart';
import 'package:graytalk/presentation/widgets/question_box.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class WriteScreen extends StatefulWidget {
  final int questionIdx;

  const WriteScreen({super.key, required this.questionIdx});

  @override
  State<WriteScreen> createState() => _WriteScreenState();
}

class _WriteScreenState extends State<WriteScreen> {
  final ScrollController _scrollController = ScrollController();
  late final String formattedDate;
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    formattedDate = DateFormat('yyyy-MM-dd E', 'ko_KR').format(DateTime.now());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _textController.dispose();
    super.dispose();
  }

  Future<void> _onCreate() async {
    final content = _textController.text;

    print(content);

    if (content.isEmpty) {
      return;
    }

    final schedule = DiaryModel(
        id: const Uuid().v4(),
        questionIdx: widget.questionIdx,
        content: content,
        date: DateTime.now());

    await FirebaseFirestore.instance
        .collection(
          'diaries',
        )
        .doc(schedule.id)
        .set(schedule.toJson());

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final questionProvider = context.watch<QuestionProvider>();

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.black,
                width: 2.0,
              ),
            ),
          ),
          child: Text(
            formattedDate,
            style: textTheme.titleLarge,
          ),
        ),
        centerTitle: true,
        leading: const SizedBox(),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          QuestionBox(
              questionIdx: widget.questionIdx,
              questionText: questionProvider.getByIdx(widget.questionIdx),
              onRefresh: () =>
                  questionProvider.refreshQuestionAt(widget.questionIdx)),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Scrollbar(
                controller: _scrollController,
                radius: const Radius.circular(10),
                child: TextField(
                  controller: _textController,
                  autofocus: true,
                  maxLines: null,
                  scrollController: _scrollController,
                  textInputAction: TextInputAction.newline,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "글을 입력해 주세요",
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.check, color: Colors.black),
                onPressed: _onCreate,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
