import '../../domain/domain.dart';

class ThemeRepoImpl implements ThemeRepo {
  @override
  Future<String> getColorScheme(String key) {
    // TODO: implement getColorScheme
    throw UnimplementedError();
  }

  @override
  Future<bool> getIsDarkMode(String key) {
    // TODO: implement getIsDarkMode
    throw UnimplementedError();
  }

  @override
  Future<void> setColorSheme(String colorScheme, String key) {
    // TODO: implement setColorSheme
    throw UnimplementedError();
  }

  @override
  Future<void> setIsDarkMode(bool isDarkMode, String key) {
    // TODO: implement setIsDarkMode
    throw UnimplementedError();
  }
}
