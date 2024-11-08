import 'package:flutter/material.dart';
import 'package:graytalk/presentation/pages/diary_screen.dart';
import 'package:graytalk/presentation/pages/home_screen.dart';
import 'package:graytalk/presentation/state/tab_idx_provider.dart';
import 'package:provider/provider.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();

    final tabIdxProvider = context.read<TabIdxProvider>();

    _tabController = TabController(
      length: 5,
      vsync: this,
      initialIndex: tabIdxProvider.currentIdx,
    );

    _tabController!.addListener(() {
      if (_tabController!.index != _tabController!.previousIndex) {
        debugPrint('Tab changed to index: ${_tabController!.index} via slide');
        tabIdxProvider.setIdx(_tabController!.index);
      }
    });
    tabIdxProvider.addListener(_tabListener);
    debugPrint('Initial tab index from provider: ${tabIdxProvider.currentIdx}');
  }

  @override
  void dispose() {
    context.read<TabIdxProvider>().removeListener(_tabListener);
    _tabController!.dispose();
    super.dispose();
  }

  void _tabListener() {
    final tabIdx = context.read<TabIdxProvider>().currentIdx;

    if (_tabController!.index != tabIdx) {
      _tabController!.animateTo(tabIdx);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final tabIdxProvider = context.watch<TabIdxProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Graytalk',
          style: textTheme.titleLarge,
        ),
        centerTitle: true,
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          Text("light"),
          DiaryScreen(),
          HomeScreen(),
          Text("check"),
          Text("settings"),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: tabIdxProvider.currentIdx,
        onTap: (int idx) {
          tabIdxProvider.setIdx(idx);
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
