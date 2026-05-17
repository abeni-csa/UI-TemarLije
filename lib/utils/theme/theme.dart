import 'package:flutter/material.dart';
import 'package:ui_temarlije/utils/constants/colors.dart';
import 'widget_themes/appbar_theme.dart';
import 'widget_themes/elevated_button_theme.dart';
import 'widget_themes/outlined_button_theme.dart';
import 'widget_themes/text_field_theme.dart';
import 'widget_themes/text_theme.dart';

class TemarLijeAppTheme {
  TemarLijeAppTheme._();

  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: TemarLijeColors.softGrey,
    brightness: Brightness.dark,
    textTheme: TemarLijeTextTheme.lightTextTheme,
    appBarTheme: TemarLijeAppBarTheme.lightAppBarTheme,
    elevatedButtonTheme: TemarLijeElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: TemarLijeOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: TemarLijeTextFormFieldTheme.lightInputDecorationTheme,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    textTheme: TemarLijeTextTheme.darkTextTheme,
    appBarTheme: TemarLijeAppBarTheme.darkAppBarTheme,
    elevatedButtonTheme: TemarLijeElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: TemarLijeOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: TemarLijeTextFormFieldTheme.darkInputDecorationTheme,
  );
}
