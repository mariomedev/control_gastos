abstract class ThemeData {
  Future<void> setColorSheme(String colorScheme, String key);
  Future<String> getColorScheme(String key);
  Future<bool> getIsDarkMode(String key);
  Future<void> setIsDarkMode(bool isDarkMode, String key);
}
