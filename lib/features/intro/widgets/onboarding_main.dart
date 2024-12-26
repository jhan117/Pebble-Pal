import 'package:flutter/material.dart';
import 'package:graytalk/app/utils/intro_messages.dart';

class OnboardingMain extends StatelessWidget {
  final int idx;

  const OnboardingMain({super.key, required this.idx});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.only(left: 40, right: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            IntroMessages.messages[idx]['img']!,
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            IntroMessages.messages[idx]['title']!,
            style: textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            IntroMessages.messages[idx]['description']!,
            style: textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
