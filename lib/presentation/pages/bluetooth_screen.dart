import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:graytalk/core/theme/colors.dart';
import 'package:graytalk/presentation/widgets/bluetooth_device_list.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graytalk/presentation/pages/root_screen.dart';
import 'package:graytalk/presentation/pages/bluetooth_check_screen.dart';

class BluetoothScreen extends StatelessWidget {
  const BluetoothScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Graytalk',
          style: textTheme.titleLarge,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Rectangle12(),
            ),
            const SizedBox(height: 16),
            Container(
              width: screenSize.width,
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        // 나중에 상세설정 기능 추가
                      },
                      child: Text(
                        '상세설정',
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurface,
                          fontWeight: FontWeight.w900,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const BluetoothCheckScreen(),
                          ),
                        );
                        Future.delayed(const Duration(seconds: 1), () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const RootScreen(),
                            ),
                          );
                        });
                      },
                      child: Text(
                        '완료',
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurface,
                          fontWeight: FontWeight.w900,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
