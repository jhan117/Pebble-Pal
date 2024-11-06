import 'package:flutter/material.dart';
import 'package:graytalk/core/theme/colors.dart';
import 'package:graytalk/presentation/state/tab_idx_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final tabIdxProvider = context.watch<TabIdxProvider>();

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
            onTap: () {
              tabIdxProvider.setIdx(1);
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 32, bottom: 32),
              margin: const EdgeInsets.only(left: 32, right: 32),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    "금요일인 오늘!",
                    style: textTheme.bodyMedium,
                  ),
                  Text(
                    '가장 기억에 남는 일이 뭐야?',
                    style: textTheme.bodyMedium,
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
