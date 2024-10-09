import 'package:flutter/material.dart';
import 'package:graytalk/core/theme/colors.dart';
import 'package:graytalk/presentation/pages/root_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => const RootScreen()), // 메인 화면으로 전환
      ),
      child: Container(
        decoration: BoxDecoration(color: colorScheme.surface),
        child: Center(
          child: Text('Graytalk', style: textTheme.titleLarge),
        ),
      ),
    );
  }
}
