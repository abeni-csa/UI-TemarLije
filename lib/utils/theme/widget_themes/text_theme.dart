import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:ui_temarlije/utils/constants/colors.dart';

/* -- Light & Dark Text Themes -- */
class TemarLijeTextTheme {
  TemarLijeTextTheme._(); //To avoid creating instances

  /* -- Light Text Theme -- */
  static TextTheme lightTextTheme = TextTheme(
    displayLarge: GoogleFonts.poppins(
      fontSize: 28.0,
      fontWeight: FontWeight.bold,
      color: TemarLijeColors.dark,
    ),
    displayMedium: GoogleFonts.poppins(
      fontSize: 24.0,
      fontWeight: FontWeight.w700,
      color: TemarLijeColors.dark,
    ),
    displaySmall: GoogleFonts.poppins(
      fontSize: 24.0,
      fontWeight: FontWeight.normal,
      color: TemarLijeColors.dark,
    ),
    headlineMedium: GoogleFonts.poppins(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: TemarLijeColors.dark,
    ),
    headlineSmall: GoogleFonts.poppins(
      fontSize: 18.0,
      fontWeight: FontWeight.normal,
      color: TemarLijeColors.dark,
    ),
    titleLarge: GoogleFonts.poppins(
      fontSize: 14.0,
      fontWeight: FontWeight.w600,
      color: TemarLijeColors.dark,
    ),
    bodyLarge: GoogleFonts.poppins(fontSize: 14.0, color: TemarLijeColors.dark),
    bodyMedium: GoogleFonts.poppins(
      fontSize: 14.0,
      color: TemarLijeColors.dark.withValues(alpha: 0.8),
    ),
  );

  /* -- Dark Text Theme -- */
  static TextTheme darkTextTheme = TextTheme(
    displayLarge: GoogleFonts.poppins(
      fontSize: 28.0,
      fontWeight: FontWeight.bold,
      color: TemarLijeColors.white,
    ),
    displayMedium: GoogleFonts.poppins(
      fontSize: 24.0,
      fontWeight: FontWeight.w700,
      color: TemarLijeColors.white,
    ),
    displaySmall: GoogleFonts.poppins(
      fontSize: 24.0,
      fontWeight: FontWeight.normal,
      color: TemarLijeColors.white,
    ),
    headlineMedium: GoogleFonts.poppins(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: TemarLijeColors.white,
    ),
    headlineSmall: GoogleFonts.poppins(
      fontSize: 18.0,
      fontWeight: FontWeight.normal,
      color: TemarLijeColors.white,
    ),
    titleLarge: GoogleFonts.poppins(
      fontSize: 14.0,
      fontWeight: FontWeight.w600,
      color: TemarLijeColors.white,
    ),
    bodyLarge: GoogleFonts.poppins(
      fontSize: 14.0,
      color: TemarLijeColors.white,
    ),
    bodyMedium: GoogleFonts.poppins(
      fontSize: 14.0,
      color: TemarLijeColors.white.withValues(alpha: 0.8),
    ),
  );
}
