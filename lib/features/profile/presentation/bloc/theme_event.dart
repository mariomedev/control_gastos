part of 'theme_bloc.dart';

abstract class ThemeEvent {
  const ThemeEvent();
}

class ThemeLoadRequested extends ThemeEvent {
  const ThemeLoadRequested();
}

class ThemeColorChanged extends ThemeEvent {
  final Color color;

  const ThemeColorChanged(this.color);
}

class ThemeDarkModeChanged extends ThemeEvent {
  final bool isDarkMode;

  const ThemeDarkModeChanged(this.isDarkMode);
}
