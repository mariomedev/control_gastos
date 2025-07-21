import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/domain.dart';
import '../../../domain/usecases/theme/theme_use_cases.dart';
import 'theme_repository_provider.dart';

final themeProviderState =
    StateNotifierProvider<ThemeNotifier, ThemeState>((ref) {
  final repository = ref.watch(themeRepositoyProvider);
  return ThemeNotifier(repository: repository);
});

class ThemeNotifier extends StateNotifier<ThemeState> {
  final ThemeRepo repository;

  ThemeNotifier({required this.repository})
      : super(
          ThemeState(
            colorScheme: Colors.transparent,
            isDarkMode: false,
          ),
        ) {
    loadTheme();
  }

  Future<void> loadTheme() async {
    final isDark = await GetDarkMode(repository).call();
    final colorScheme = await GetColorScheme(repository).call();

    state = state.copyWith(
      colorScheme: colorScheme,
      isDarkMode: isDark,
    );
  }

  Future<void> onChangeTheme(Color color) async {
    state = state.copyWith(colorScheme: color);
    await SetColorScheme(repository)(color);
  }

  Future<void> onChangeDarkMode(bool value) async {
    state = state.copyWith(isDarkMode: value);
    await SetDarkMode(repository)(value);
  }
}

class ThemeState {
  final Color colorScheme;
  final bool isDarkMode;

  ThemeState({
    required this.colorScheme,
    required this.isDarkMode,
  });

  ThemeState copyWith({
    Color? colorScheme,
    bool? isDarkMode,
  }) =>
      ThemeState(
        colorScheme: colorScheme ?? this.colorScheme,
        isDarkMode: isDarkMode ?? this.isDarkMode,
      );
}
