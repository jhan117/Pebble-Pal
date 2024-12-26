import 'package:flutter/material.dart';
import 'package:graytalk/features/diary/screen/diary_calendar_screen.dart';
import 'package:graytalk/features/diary/screen/diary_screen.dart';
import 'package:graytalk/features/home_screen.dart';
import 'package:graytalk/features/diary/state/question_provider.dart';
import 'package:graytalk/features/light/screen/lighting_screen.dart';
import 'package:graytalk/features/settings/screen/settings_screen.dart';
import 'package:provider/provider.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _curPage = 2;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(initialPage: _curPage);
  }

  @override
  void dispose() {
    super.dispose();

    _pageController.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _curPage = page;
    });

    if (page == 2) {
      context.read<QuestionProvider>().getRandQuestion();
    }
  }

  void _onItemTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Graytalk',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        centerTitle: true,
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: const [
          LightingScreen(),
          DiaryScreen(),
          HomeScreen(),
          DiaryCalendarScreen(),
          SettingsScreen()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _curPage,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb),
            label: "무드등",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.layers),
            label: "일기",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.eco),
            label: "홈",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: "월간 일기",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "설정",
          ),
        ],
      ),
    );
  }
}
