import 'package:flutter/material.dart';
import 'package:graytalk/features/diary/widgets/question_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
        const QuestionCard(margin: EdgeInsets.all(32)),
      ],
    );
  }
}
