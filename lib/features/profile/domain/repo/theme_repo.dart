import 'package:flutter/widgets.dart';

abstract class ThemeRepo {
  Future<void> setColorSheme(Color colorScheme);
  Future<Color> getColorScheme();
  Future<void> setIsDarkMode(bool isDarkMode);
  Future<bool> getIsDarkMode();
}
