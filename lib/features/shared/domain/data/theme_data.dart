import 'package:flutter/material.dart';

abstract class ThemeDataDomain {
  Future<void> setColorSheme(int colorScheme, String key);
  Future<Color> getColorScheme(String key);
  Future<bool> getIsDarkMode(String key);
  Future<void> setIsDarkMode(bool isDarkMode, String key);
}
