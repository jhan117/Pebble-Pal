import 'package:flutter/material.dart';
import 'package:graytalk/presentation/widgets/calendar.dart';
import 'package:graytalk/presentation/pages/home_screen.dart';

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

    _tabController = TabController(length: 5, vsync: this);
    _tabController!.index = 2;
    _tabController!.addListener(tabListener);
  }

  void tabListener() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Graytalk',
            style: textTheme.titleLarge,
          ),
          centerTitle: true,
        ),
        body:
            TabBarView(controller: _tabController, children: renderChildren()),
        bottomNavigationBar: renderBottomNavigation());
  }

  List<Widget> renderChildren() {
    return [
      const Text("light"),
      const Text("stack"),
      const HomeScreen(),
      const CalendarWidget(),
      const Text("settings"),
    ];
  }

  BottomNavigationBar renderBottomNavigation() {
    return BottomNavigationBar(
      currentIndex: _tabController!.index,
      onTap: (int idx) {
        setState(() {
          _tabController!.animateTo(idx);
        });
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.lightbulb), label: "무드등"),
        BottomNavigationBarItem(icon: Icon(Icons.layers), label: "일기"),
        BottomNavigationBarItem(icon: Icon(Icons.eco), label: "홈"),
        BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today), label: "월간 일기"),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: "설정"),
      ],
    );
  }
}
