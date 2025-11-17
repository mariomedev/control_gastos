part of 'theme_bloc.dart';

class ThemeState {
  final Color colorScheme;
  final bool isDarkMode;
  final bool isLoading;

  const ThemeState({
    this.colorScheme = const Color(0xFF2196F3),
    this.isDarkMode = false,
    this.isLoading = false,
  });

  ThemeState copyWith({
    Color? colorScheme,
    bool? isDarkMode,
    bool? isLoading,
  }) {
    return ThemeState(
      colorScheme: colorScheme ?? this.colorScheme,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
