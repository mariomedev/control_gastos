import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/domain.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final GetColorScheme _getColorScheme;
  final GetDarkMode _getDarkMode;
  final SetColorScheme _setColorScheme;
  final SetDarkMode _setDarkMode;

  ThemeBloc({
    required GetColorScheme getColorScheme,
    required GetDarkMode getDarkMode,
    required SetColorScheme setColorScheme,
    required SetDarkMode setDarkMode,
  })  : _getColorScheme = getColorScheme,
        _getDarkMode = getDarkMode,
        _setColorScheme = setColorScheme,
        _setDarkMode = setDarkMode,
        super(const ThemeState()) {
    on<ThemeLoadRequested>(_onThemeLoadRequested);
    on<ThemeColorChanged>(_onThemeColorChanged);
    on<ThemeDarkModeChanged>(_onThemeDarkModeChanged);
  }

  Future<void> _onThemeLoadRequested(
    ThemeLoadRequested event,
    Emitter<ThemeState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    try {
      final isDark = await _getDarkMode.call();
      final colorScheme = await _getColorScheme.call();

      emit(state.copyWith(
        colorScheme: colorScheme,
        isDarkMode: isDark,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _onThemeColorChanged(
    ThemeColorChanged event,
    Emitter<ThemeState> emit,
  ) async {
    final previousColor = state.colorScheme;
    emit(state.copyWith(colorScheme: event.color));

    try {
      await _setColorScheme.call(event.color);
    } catch (e) {
      emit(state.copyWith(colorScheme: previousColor));
    }
  }

  Future<void> _onThemeDarkModeChanged(
    ThemeDarkModeChanged event,
    Emitter<ThemeState> emit,
  ) async {
    final previousDarkMode = state.isDarkMode;
    emit(state.copyWith(isDarkMode: event.isDarkMode));

    try {
      await _setDarkMode.call(event.isDarkMode);
    } catch (e) {
      emit(state.copyWith(isDarkMode: previousDarkMode));
    }
  }
}
