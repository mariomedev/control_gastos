import 'package:flutter/material.dart';

abstract class ThemeDataDomain {
  Future<void> setColorSheme(Color colorScheme);
  Future<Color> getColorScheme();
  Future<void> setIsDarkMode(bool isDarkMode);
  Future<bool> getIsDarkMode();
}
