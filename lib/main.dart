import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:graytalk/app/theme/app_theme.dart';
import 'package:graytalk/features/diary/state/diary_provider.dart';
import 'package:graytalk/firebase_options.dart';
import 'package:graytalk/features/common/screen/splash_screen.dart';
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
    ],
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: const SplashScreen(),
    );
  }
}
