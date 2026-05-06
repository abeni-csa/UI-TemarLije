import 'package:flutter/material.dart';

import 'package:ui_temarlije/utils/constants/colors.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

/* -- Light & Dark Outlined Button Themes -- */
class TemarLijeOutlinedButtonTheme {
  TemarLijeOutlinedButtonTheme._(); //To avoid creating instances

  /* -- Light Theme -- */
  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: TemarLijeColors.secondary,
      side: const BorderSide(color: TemarLijeColors.secondary),
      padding: const EdgeInsets.symmetric(
        vertical: TemarLijeSizes.buttonHeight,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(TemarLijeSizes.borderRadiusLg),
      ),
    ),
  );

  /* -- Dark Theme -- */
  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: TemarLijeColors.white,
      side: const BorderSide(color: TemarLijeColors.white),
      padding: const EdgeInsets.symmetric(
        vertical: TemarLijeSizes.buttonHeight,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(TemarLijeSizes.borderRadiusLg),
      ),
    ),
  );
}
