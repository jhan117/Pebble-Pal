import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graytalk/app/styles/app_colors.dart';

class AppTextStyles {
  static TextStyle headlineMedium(Color color) => TextStyle(
        fontFamily: GoogleFonts.sarpanch().fontFamily,
        fontSize: 26,
        fontWeight: FontWeight.w900,
        color: color,
      );

  static TextStyle titleMedium(Color color) => TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w800,
        color: color,
      );

  static bodyLarge(Color color) => TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: color,
      );

  static bodyMedium(Color color) => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: color,
      );

  static bodySmall(Color color) => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: color,
      );

  static labelLarge(Color color) => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: color,
      );

  static labelMedium(Color color) => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: color,
      );

  static labelSmall(Color color) => TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: color,
      );

  // light mode
  static TextTheme lightTextTheme = TextTheme(
    headlineMedium: headlineMedium(AppColors.primaryColor),
    titleMedium: titleMedium(AppColors.lightText),
    bodyLarge: bodyLarge(AppColors.lightText),
    bodyMedium: bodyMedium(AppColors.lightText),
    bodySmall: bodySmall(AppColors.lightText),
    labelLarge: labelLarge(AppColors.lightText),
    labelMedium: labelMedium(AppColors.lightText),
    labelSmall: labelSmall(AppColors.lightText),
  );

  // dark mode
  static TextTheme darkTextTheme = TextTheme(
    headlineMedium: headlineMedium(AppColors.primaryColor),
    titleMedium: titleMedium(AppColors.darkText),
    bodyLarge: bodyLarge(AppColors.darkText),
    bodyMedium: bodyMedium(AppColors.darkText),
    bodySmall: bodySmall(AppColors.darkText),
    labelLarge: labelLarge(AppColors.darkText),
    labelMedium: labelMedium(AppColors.darkText),
    labelSmall: labelSmall(AppColors.darkText),
  );
}
