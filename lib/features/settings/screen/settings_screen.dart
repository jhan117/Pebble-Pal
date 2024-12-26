import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graytalk/features/settings/state/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Theme.of(context).cardColor,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "다크 모드",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              CupertinoSwitch(
                  value: themeProvider.isDarkMode,
                  onChanged: (value) => themeProvider.toggleTheme()),
            ],
          ),
        ),
      ),
    );
  }
}
