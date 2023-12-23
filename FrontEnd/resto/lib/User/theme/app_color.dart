import 'package:flutter/material.dart';

class AppColorsLight {
  static const appBarColor = Colors.white;
  static const primaryColor = Colors.deepOrange;
  static const secondaryColor = Colors.grey;
  static const lightColor = Colors.white;
}

ThemeData getThemeDataLight() => ThemeData(
      useMaterial3: true,
      colorSchemeSeed: AppColorsLight.primaryColor,
      appBarTheme: const AppBarTheme(color: AppColorsLight.appBarColor),
      sliderTheme:
          const SliderThemeData(showValueIndicator: ShowValueIndicator.always),
    );
