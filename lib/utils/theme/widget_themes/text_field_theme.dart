import 'package:flutter/material.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';
import 'package:ui_temarlije/utils/constants/sizes.dart';

class TemarLijeTextFormFieldTheme {
  TemarLijeTextFormFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    prefixIconColor: TemarLijeColors.secondary,
    floatingLabelStyle: const TextStyle(color: TemarLijeColors.secondary),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(TemarLijeSizes.borderRadiusLg),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(TemarLijeSizes.borderRadiusLg),
      borderSide: const BorderSide(width: 2, color: TemarLijeColors.secondary),
    ),
  );

  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    prefixIconColor: TemarLijeColors.primary,
    floatingLabelStyle: const TextStyle(color: TemarLijeColors.primary),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(TemarLijeSizes.borderRadiusLg),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(TemarLijeSizes.borderRadiusLg),
      borderSide: const BorderSide(width: 2, color: TemarLijeColors.primary),
    ),
  );
}
