import 'package:flutter/material.dart';
import 'package:graytalk/features/diary/state/question_provider.dart';
import 'package:graytalk/features/diary/widgets/question_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void refreshQuestion() {
    final questionProvider = context.read<QuestionProvider>();

    questionProvider.refreshQuestionAt(questionProvider.selectedIdx);
  }

  @override
  Widget build(BuildContext context) {
    final questionProvider = context.watch<QuestionProvider>();
    String question = questionProvider.getByIdx();

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
          QuestionCard(
            index: questionProvider.selectedIdx,
            question: question,
            onRefresh: refreshQuestion,
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
