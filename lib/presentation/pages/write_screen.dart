import 'package:flutter/material.dart';
import 'package:graytalk/presentation/state/question_provider.dart';
import 'package:graytalk/presentation/widgets/question_box.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class WriteScreen extends StatefulWidget {
  final int questionIdx;

  const WriteScreen({super.key, required this.questionIdx});

  @override
  State<WriteScreen> createState() => _WriteScreenState();
}

class _WriteScreenState extends State<WriteScreen> {
  final ScrollController _scrollController = ScrollController();
  late final String formattedDate;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('ko_KR', null);
    formattedDate = DateFormat('yyyy-MM-dd E', 'ko_KR').format(DateTime.now());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
              Navigator.pop(context);
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
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
