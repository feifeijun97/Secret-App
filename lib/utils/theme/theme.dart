import 'package:flutter/material.dart';

enum AppTheme {
  light,
  dark,
}

final appThemeData = {
  AppTheme.dark: ThemeData.dark(),
  AppTheme.light: ThemeData.light(),
};

final blackThemeData = ThemeData(
  colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: Colors.red.shade400,
      onPrimary: Colors.red.shade200,
      background: Colors.black87,
      error: Color(),
      onBackground: Colors.black54,
      onError: null,
      onSecondary: null,
      onSurface: null,
      secondary: null,
      surface: null),
);
