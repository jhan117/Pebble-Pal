import 'package:flutter/material.dart';
import 'package:graytalk/app/theme/colors.dart';
import 'package:graytalk/main.dart';
import 'package:graytalk/features/common/screen/intro_screen.dart';
import 'package:graytalk/features/common/screen/root_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) =>
                isDebugMode ? const RootScreen() : const IntroScreen()));
      },
      child: Container(
        color: colorScheme.surface,
        child: Center(
          child: Text(
            'Graytalk',
            style: textTheme.titleLarge,
          ),
        ),
      ),
    );
  }
}
