import 'package:flutter/material.dart';
import 'package:graytalk/core/theme/app_theme.dart';
import 'package:graytalk/presentation/pages/splash_screen.dart';
import 'package:graytalk/presentation/state/question_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';

const String skipBluetooth =
    String.fromEnvironment('SKIP_BLUETOOTH', defaultValue: 'false');
const bool isDebugMode = skipBluetooth == 'true';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();

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
      theme: appTheme,
      home: const SplashScreen(),
    );
  }
}
