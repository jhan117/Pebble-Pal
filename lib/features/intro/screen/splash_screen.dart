import 'package:flutter/material.dart';
import 'package:graytalk/main.dart';
import 'package:graytalk/features/intro/screen/onboarding_screen.dart';
import 'package:graytalk/features/root_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) =>
                isDebugMode ? const RootScreen() : const OnboardingScreen()));
      },
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Center(
          child: Text(
            'Graytalk',
            style: textTheme.headlineMedium,
          ),
        ),
      ),
    );
  }
}
