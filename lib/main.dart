import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graytalk/core/theme/colors.dart';
import 'package:graytalk/core/theme/fonts.dart';
import 'package:graytalk/presentation/pages/root_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: GoogleFonts.notoSans().fontFamily,
          textTheme: TextTheme(
            titleLarge: titleLarge,
            bodyMedium: bodyMedium,
          ),
          scaffoldBackgroundColor: backgroundColor,
          appBarTheme: const AppBarTheme(
            backgroundColor: backgroundColor,
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: primaryFontColor,
            unselectedItemColor: secondaryFontColor,
            backgroundColor: backgroundColor,
          )),
      home: const RootScreen(),
    );
  }
}
