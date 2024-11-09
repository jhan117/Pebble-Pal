import 'package:flutter/material.dart';
import 'package:graytalk/core/theme/colors.dart';
import 'package:graytalk/presentation/pages/write_screen.dart';

class QuestionBox extends StatelessWidget {
  final String questionText;
  final VoidCallback onRefresh;

  const QuestionBox({
    super.key,
    required this.questionText,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    List<String> splitText = questionText.split('\n');

    return GestureDetector(
      onTap: () => Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const WriteScreen())),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 140,
            padding: const EdgeInsets.only(top: 32, bottom: 32),
            margin: const EdgeInsets.only(left: 32, right: 32),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  splitText[0],
                  style: textTheme.bodyMedium,
                ),
                splitText.length > 1
                    ? Text(
                        splitText[1],
                        style: textTheme.bodyMedium,
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
          Positioned(
            top: 4,
            right: 36,
            child: IconButton(
              icon: const Icon(Icons.refresh),
              iconSize: 32,
              onPressed: onRefresh,
            ),
          ),
        ],
      ),
    );
  }
}
