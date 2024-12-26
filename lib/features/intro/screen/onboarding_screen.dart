import 'package:flutter/material.dart';
import 'package:graytalk/features/intro/screen/bluetooth_screen.dart';
import 'package:graytalk/features/intro/widgets/onboarding_footer.dart';
import 'package:graytalk/features/intro/widgets/onboarding_main.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _introPageController = PageController();

  int curPage = 1;
  int pageLength = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Text(
          '${curPage.toString()}/$pageLength',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const BluetoothScreen()));
            },
            child: const Text(
              'Skip',
            ),
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(12, 16, 12, 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: PageView.builder(
                controller: _introPageController,
                onPageChanged: (v) {
                  setState(() {
                    curPage = v + 1;
                  });
                },
                itemCount: pageLength,
                itemBuilder: (BuildContext context, int idx) => OnboardingMain(
                  idx: idx,
                ),
              ),
            ),
            OnboardingFooter(
              controller: _introPageController,
              curPage: curPage,
              pageLength: pageLength,
            ),
          ],
        ),
      ),
    );
  }
}
