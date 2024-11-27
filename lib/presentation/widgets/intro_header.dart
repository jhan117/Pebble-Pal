import 'package:flutter/material.dart';
import 'package:graytalk/presentation/pages/bluetooth_screen.dart';

class IntroHeader extends StatelessWidget {
  final int pageNum;
  final int pageLength;

  const IntroHeader({
    super.key,
    required this.pageNum,
    required this.pageLength,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: null,
          child: Text(
            '${pageNum.toString()}/$pageLength',
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const BluetoothScreen()));
          },
          child: const Text(
            'Skip',
          ),
        ),
      ],
    );
  }
}
