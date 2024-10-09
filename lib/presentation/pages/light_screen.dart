import 'package:flutter/material.dart';

class LightScreen extends StatelessWidget {
  const LightScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
            onPressed: () {},
            child: Text(
              'On',
              style: textTheme.bodyMedium,
            )),
        const SizedBox(
          width: 16,
        ),
        ElevatedButton(
            onPressed: () {},
            child: Text(
              'Off',
              style: textTheme.bodyMedium,
            )),
      ],
    );
  }
}
