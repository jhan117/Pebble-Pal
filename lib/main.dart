import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:graytalk/app/styles/app_theme.dart';
import 'package:graytalk/features/diary/state/diary_provider.dart';
import 'package:graytalk/features/settings/state/theme_provider.dart';
import 'package:graytalk/firebase_options.dart';
import 'package:graytalk/features/intro/screen/splash_screen.dart';
import 'package:graytalk/features/diary/state/question_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';

const String skipBluetooth =
    String.fromEnvironment('SKIP_BLUETOOTH', defaultValue: 'false');
const bool isDebugMode = skipBluetooth == 'true';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => QuestionProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => DiaryProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
      ),
    ],
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeProvider.isDarkMode ? darkTheme : lightTheme,
      home: const SplashScreen(),
    );
  }
}
