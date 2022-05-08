import 'package:flutter/material.dart';

enum AppTheme {
  light,
  dark,
}

final appThemeData = {
  AppTheme.dark: ThemeData.dark(),
  AppTheme.light: ThemeData.light(),
};
