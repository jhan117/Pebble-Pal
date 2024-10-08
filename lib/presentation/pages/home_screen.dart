import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: Image.asset(
              'assets/imgs/rock_pet.jpg',
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 24, bottom: 24),
            margin: const EdgeInsets.only(left: 24, right: 24),
            decoration: BoxDecoration(
                color: const Color(0xfffdeeee),
                borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                Text(
                  "금요일인 오늘!",
                  style: textTheme.bodyMedium,
                ),
                Text(
                  '가장 기억에 남는 일이 뭐야?',
                  style: textTheme.bodyMedium,
                )
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
