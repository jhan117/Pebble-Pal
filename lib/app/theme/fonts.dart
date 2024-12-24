import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graytalk/app/theme/colors.dart';

final textTheme = TextTheme(
  titleLarge: titleLarge,
  headlineMedium: headlineMedium,
  bodyMedium: bodyMedium,
);

final titleLarge = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.w900,
  fontFamily: GoogleFonts.sarpanch().fontFamily,
  color: colorScheme.inversePrimary,
);

final headlineMedium = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.w800,
  color: colorScheme.onSurface,
);

final bodyLarge = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w600,
  color: colorScheme.onSurfaceVariant,
);

final bodyMedium = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.normal,
  color: colorScheme.onSurfaceVariant,
  height: 1.7,
);
