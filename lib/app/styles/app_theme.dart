import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graytalk/app/styles/app_colors.dart';
import 'package:graytalk/app/styles/app_text_styles.dart';

final String? commonFont = GoogleFonts.notoSans().fontFamily;

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  fontFamily: commonFont,
  textTheme: AppTextStyles.lightTextTheme,
  scaffoldBackgroundColor: AppColors.lightBackground,
  cardColor: AppColors.lightCard,
  appBarTheme: const AppBarTheme(backgroundColor: AppColors.lightBackground),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: AppColors.lightBackground,
    selectedItemColor: AppColors.primaryColor,
    unselectedItemColor: AppColors.lightDisabledText,
    selectedLabelStyle: AppTextStyles.labelMedium(AppColors.lightText),
    unselectedLabelStyle: AppTextStyles.labelSmall(AppColors.lightText),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryColor,
      foregroundColor: AppColors.lightBackground,
      textStyle: AppTextStyles.bodyMedium(AppColors.lightText),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      disabledBackgroundColor: AppColors.primaryColor,
      disabledForegroundColor: AppColors.lightBackground,
    ),
  ),
  iconButtonTheme: IconButtonThemeData(
    style: IconButton.styleFrom(foregroundColor: AppColors.lightText),
  ),
  // textButtonTheme: TextButtonThemeData(
  //   style: TextButton.styleFrom(
  //     foregroundColor: AppColors.lightText,
  //     textStyle: AppTextStyles.bodyMedium(AppColors.lightText),
  //     disabledForegroundColor: Colors.amber,
  //   ),
  // ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  fontFamily: commonFont,
  textTheme: AppTextStyles.darkTextTheme,
  scaffoldBackgroundColor: AppColors.darkBackground,
  cardColor: AppColors.darkCard,
  appBarTheme: const AppBarTheme(backgroundColor: AppColors.darkBackground),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: AppColors.darkBackground,
    selectedItemColor: AppColors.primaryColor,
    unselectedItemColor: AppColors.darkDisabledText,
    selectedLabelStyle: AppTextStyles.labelMedium(AppColors.darkText),
    unselectedLabelStyle: AppTextStyles.labelSmall(AppColors.darkText),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryColor,
      foregroundColor: AppColors.darkBackground,
      textStyle: AppTextStyles.bodyMedium(AppColors.darkText),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      disabledBackgroundColor: AppColors.primaryColor,
      disabledForegroundColor: AppColors.darkBackground,
    ),
  ),
  iconButtonTheme: IconButtonThemeData(
    style: IconButton.styleFrom(foregroundColor: AppColors.darkText),
  ),
);
