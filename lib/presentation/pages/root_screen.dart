import 'package:flutter/material.dart';
import 'package:graytalk/presentation/pages/diary_screen.dart';
import 'package:graytalk/presentation/pages/home_screen.dart';
import 'package:graytalk/presentation/state/page_provider.dart';
import 'package:provider/provider.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();

    final pageProvider = context.read<PageProvider>();
    _pageController = PageController(initialPage: pageProvider.curIdx);

    _pageController.addListener(_pageChangeListener);
    pageProvider.addListener(_pageProviderListener);

    debugPrint('Initial tab index from provider: ${pageProvider.curIdx}');
  }

  @override
  void dispose() {
    super.dispose();

    context.read<PageProvider>().removeListener(_pageProviderListener);
    _pageController.dispose();
  }

  void _pageChangeListener() {
    final page = _pageController.page?.round();
    final pageProvider = context.read<PageProvider>();
    if (page != null && page != pageProvider.curIdx) {
      pageProvider.setIdx(page);

      debugPrint('Page changed to index: $page via slide');
    }
  }

  void _pageProviderListener() {
    final curPage = context.read<PageProvider>().curIdx;

    if (_pageController.page?.round() != curPage) {
      _pageController.animateToPage(
        curPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final pageProvider = context.watch<PageProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Graytalk',
          style: textTheme.titleLarge,
        ),
        centerTitle: true,
      ),
      body: PageView(
        controller: _pageController,
        children: const [
          Text("light"),
          DiaryScreen(),
          HomeScreen(),
          Text("check"),
          Text("settings"),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageProvider.curIdx,
        onTap: (int idx) {
          pageProvider.setIdx(idx);
        },
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
