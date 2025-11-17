import 'package:flutter/material.dart';

import '../../features/profile/profile_feature.dart';

ThemeData buildTheme(ThemeState themeState) {
  final isDarkMode = themeState.isDarkMode;
  final colorScheme = themeState.colorScheme;

  if (isDarkMode) {
    return ThemeData(
      colorScheme: ColorScheme.dark(
        primary: colorScheme,
      ),
    );
  }
  return ThemeData(
    colorScheme: ColorScheme.light(
      primary: colorScheme,
    ),
  );
}
