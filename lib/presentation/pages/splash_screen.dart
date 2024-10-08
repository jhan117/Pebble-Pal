import 'package:flutter/material.dart';
import 'package:graytalk/presentation/pages/root_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => const RootScreen()), // 메인 화면으로 전환
      ),
      child: Container(
        width: screenWidth,
        height: screenHeight,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: screenWidth,
                height: screenHeight,
                decoration: const BoxDecoration(
                  color: Color(0xFFF8F3E6),
                ),
                child: const Center(
                  child: DefaultTextStyle(
                    style: TextStyle(
                      color: Color(0xFFF1B2B2),
                      fontSize: 27,
                      fontFamily: 'Sarpanch',
                      fontWeight: FontWeight.w900,
                    ),
                    child: Text('Graytalk'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
