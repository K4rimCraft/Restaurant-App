import 'package:flutter/material.dart';

class AppColorsLight {
  static bool darkMode = true;
  static const appBarColor = Colors.white;
  static const primaryColor = Colors.deepOrange;
  static const secondaryColor = Colors.grey;
  static const lightColor = Colors.white;
  static ThemeData currentTheme = ThemeData(
    brightness: darkMode ? Brightness.dark : Brightness.light,
    useMaterial3: true,
    colorSchemeSeed: Colors.deepOrange,
    sliderTheme:
        const SliderThemeData(showValueIndicator: ShowValueIndicator.always),
  );
}
