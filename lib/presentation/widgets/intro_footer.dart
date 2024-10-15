import 'package:flutter/material.dart';
import 'package:graytalk/core/theme/colors.dart';
import 'package:graytalk/presentation/pages/root_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:graytalk/presentation/pages/bluetooth_screen.dart';

class IntroFooter extends StatelessWidget {
  final PageController controller;

  final int curPage;
  final int pageLength;

  const IntroFooter({
    super.key,
    required this.controller,
    required this.curPage,
    required this.pageLength,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: colorScheme.outlineVariant,
          ),
          onPressed: () {
            controller.previousPage(
              duration: const Duration(milliseconds: 400),
              curve: Curves.ease,
            );
          },
          child: const Text('Prev'),
        ),
        SmoothPageIndicator(
          controller: controller,
          count: pageLength,
          effect: const ExpandingDotsEffect(),
        ),
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: colorScheme.primary,
          ),
          onPressed: () {
            if (curPage == pageLength) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const BluetoothScreen()));
            } else {
              controller.nextPage(
                duration: const Duration(milliseconds: 400),
                curve: Curves.ease,
              );
            }
          },
          child:
              curPage == pageLength ? const Text('Start') : const Text('Next'),
        ),
      ],
    );
  }
}
