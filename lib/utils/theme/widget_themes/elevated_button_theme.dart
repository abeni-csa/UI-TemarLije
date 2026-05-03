import 'package:flutter/material.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

/* -- Light & Dark Elevated Button Themes -- */
class TemarLijeElevatedButtonTheme {
  TemarLijeElevatedButtonTheme._(); //To avoid creating instances

  /* -- Light Theme -- */
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: TemarLijeColors.white,
      backgroundColor: TemarLijeColors.dark,
      side: const BorderSide(color: TemarLijeColors.dark),
      padding: const EdgeInsets.symmetric(
        vertical: TemarLijeSizes.buttonHeight,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(TemarLijeSizes.borderRadiusLg),
      ),
    ),
  );

  /* -- Dark Theme -- */
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: TemarLijeColors.dark,
      backgroundColor: TemarLijeColors.primary,
      side: const BorderSide(color: TemarLijeColors.primary),
      padding: const EdgeInsets.symmetric(
        vertical: TemarLijeSizes.buttonHeight,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(TemarLijeSizes.borderRadiusLg),
      ),
    ),
  );
}
