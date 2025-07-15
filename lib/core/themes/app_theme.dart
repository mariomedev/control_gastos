import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:control_gastos/features/profile/presentation/provider/providers.dart';

final themeGlobalProvider = Provider<ThemeData>((ref) {
  final isDarkMode = ref.watch(themeProviderState).isDarkMode;
  final colorSheme = ref.watch(themeProviderState).colorScheme;

  if (isDarkMode) {
    return ThemeData(
      colorScheme: ColorScheme.dark(
        primary: colorSheme,
      ),
    );
  }
  if (!isDarkMode) {
    return ThemeData(
      colorScheme: ColorScheme.light(
        primary: colorSheme,
      ),
    );
  }
  return ThemeData();
});
