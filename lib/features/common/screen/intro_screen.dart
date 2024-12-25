import 'package:flutter/material.dart';
import 'package:graytalk/app/theme/colors.dart';
import 'package:graytalk/features/common/widgets/intro_footer.dart';
import 'package:graytalk/features/common/widgets/intro_header.dart';
import 'package:graytalk/features/common/widgets/intro_main.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _introPageController = PageController();

  int curPage = 1;
  int pageLength = 3;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorScheme.surface,
      child: SafeArea(
        child: Container(
          margin: const EdgeInsets.fromLTRB(12, 16, 12, 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IntroHeader(
                pageNum: curPage,
                pageLength: pageLength,
              ),
              Expanded(
                child: PageView.builder(
                  controller: _introPageController,
                  onPageChanged: (v) {
                    setState(() {
                      curPage = v + 1;
                    });
                  },
                  itemCount: pageLength,
                  itemBuilder: (BuildContext context, int idx) => IntroMain(
                    idx: idx,
                  ),
                ),
              ),
              IntroFooter(
                controller: _introPageController,
                curPage: curPage,
                pageLength: pageLength,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
