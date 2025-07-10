import 'package:flutter/widgets.dart';

abstract class ThemeRepo {
  Future<void> setColorSheme(Color colorScheme, String key);
  Future<Color> getColorScheme(String key);
  Future<bool> getIsDarkMode(String key);
  Future<void> setIsDarkMode(bool isDarkMode, String key);
}
