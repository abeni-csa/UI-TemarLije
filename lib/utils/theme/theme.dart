import 'package:flutter/material.dart';

import 'widget_themes/appbar_theme.dart';
import 'widget_themes/elevated_button_theme.dart';
import 'widget_themes/outlined_button_theme.dart';
import 'widget_themes/text_field_theme.dart';
import 'widget_themes/text_theme.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    brightness: Brightness.light,
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
