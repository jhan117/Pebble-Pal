import 'dart:math';
import 'package:flutter/material.dart';
import 'package:graytalk/presentation/state/question_provider.dart';
import 'package:graytalk/presentation/state/page_provider.dart';
import 'package:graytalk/presentation/widgets/question_box.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? selectedIndex;
  String q = "";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (context.read<PageProvider>().curIdx == 2) {
      final randomQuestions = context.read<QuestionProvider>().randomQuestions;
      selectedIndex = Random().nextInt(randomQuestions.length);
      q = randomQuestions[selectedIndex!];

      debugPrint('didChangeDependencies called');
      debugPrint('Selected index: $selectedIndex');
      debugPrint('Selected question: $q');
    }
  }

  void refreshQuestion() {
    if (selectedIndex != null) {
      final questionProvider = context.read<QuestionProvider>();
      questionProvider.refreshQuestionAt(selectedIndex!);
      final randomQuestions = questionProvider.randomQuestions;

      debugPrint('Refreshing question at index: $selectedIndex');
      debugPrint('New question: ${randomQuestions[selectedIndex!]}');

      setState(() {
        q = randomQuestions[selectedIndex!];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final tabIdxProvider = context.watch<PageProvider>();

    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: Image.asset(
              'assets/imgs/rock_pet.jpg',
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () => tabIdxProvider.setIdx(1),
            child: QuestionBox(
              questionText: q,
              onRefresh: refreshQuestion,
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
