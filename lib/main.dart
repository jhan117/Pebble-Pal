import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graytalk/core/theme/colors.dart';
import 'package:graytalk/core/theme/fonts.dart';
import 'package:graytalk/presentation/pages/splash_screen.dart';
import 'package:graytalk/presentation/state/question_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => QuestionProvider(),
    child: const MainApp(),
  ));
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
          headlineMedium: headlineMedium,
          bodyMedium: bodyMedium,
        ),
        scaffoldBackgroundColor: colorScheme.surface,
        appBarTheme: AppBarTheme(
          backgroundColor: colorScheme.surface,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: colorScheme.onSurface,
          unselectedItemColor: colorScheme.outlineVariant,
          backgroundColor: colorScheme.surface,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: colorScheme.primaryContainer,
            foregroundColor: colorScheme.onPrimaryContainer,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: colorScheme.onSurface,
            textStyle: bodyLarge,
            disabledForegroundColor: colorScheme.onSurface,
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
