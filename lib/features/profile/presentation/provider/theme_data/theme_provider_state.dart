import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/domain.dart';
import 'theme_repository_provider.dart';

final themeProviderState =
    StateNotifierProvider<ThemeNotifier, ThemeState>((ref) {
  final repo = ref.watch(themeRepositoyProvider);
  return ThemeNotifier(repo: repo);
});

class ThemeNotifier extends StateNotifier<ThemeState> {
  final ThemeRepo repo;

  ThemeNotifier({required this.repo})
      : super(
          ThemeState(
            colorSheme: Colors.red,
            isDarkMode: false,
          ),
        );

  void onChangeTheme(Color color, String key) {
    state = state.copyWity(colorSheme: color);
    repo.setColorSheme(color, key);
  }

  void onChangeDarkMode(bool value, String key) {
    state = state.copyWity(isDarkMode: value);
    repo.setIsDarkMode(value, key);
  }
}

class ThemeState {
  final Color colorSheme;
  final bool isDarkMode;

  ThemeState({
    required this.colorSheme,
    required this.isDarkMode,
  });

  ThemeState copyWity({
    Color? colorSheme,
    bool? isDarkMode,
  }) =>
      ThemeState(
        colorSheme: colorSheme ?? this.colorSheme,
        isDarkMode: isDarkMode ?? this.isDarkMode,
      );
}
