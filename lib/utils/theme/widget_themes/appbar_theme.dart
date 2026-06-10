import 'package:flutter/material.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';

class TemarLijeAppBarTheme {
  TemarLijeAppBarTheme._();

  static const lightAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: true,
    backgroundColor: Colors.transparent,
    iconTheme: IconThemeData(color: TemarLijeColors.dark, size: 18.0),
    actionsIconTheme: IconThemeData(color: TemarLijeColors.dark, size: 18.0),
  );
  static const darkAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: true,
    backgroundColor: Colors.transparent,
    iconTheme: IconThemeData(color: TemarLijeColors.white, size: 18.0),
    actionsIconTheme: IconThemeData(color: TemarLijeColors.white, size: 18.0),
  );
}
