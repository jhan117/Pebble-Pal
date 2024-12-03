import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graytalk/core/theme/colors.dart';
import 'package:graytalk/core/theme/fonts.dart';

final appTheme = ThemeData(
  fontFamily: GoogleFonts.notoSans().fontFamily,
  textTheme: textTheme,
  scaffoldBackgroundColor: defaultBG,
  appBarTheme: AppBarTheme(
    backgroundColor: defaultBG,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: colorScheme.onSurface,
    unselectedItemColor: colorScheme.outlineVariant,
    backgroundColor: defaultBG,
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
);
