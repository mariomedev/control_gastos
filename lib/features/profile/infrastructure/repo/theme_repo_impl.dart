import 'package:flutter/widgets.dart';

import '../../domain/domain.dart';

class ThemeRepoImpl implements ThemeRepo {
  final ThemeDataDomain dataSource;

  ThemeRepoImpl({required this.dataSource});

  @override
  Future<Color> getColorScheme(String key) async {
    return dataSource.getColorScheme(key);
  }

  @override
  Future<bool> getIsDarkMode(String key) {
    return dataSource.getIsDarkMode(key);
  }

  @override
  Future<void> setColorSheme(Color colorScheme, String key) {
    return dataSource.setColorSheme(colorScheme, key);
  }

  @override
  Future<void> setIsDarkMode(bool isDarkMode, String key) {
    return dataSource.setIsDarkMode(isDarkMode, key);
  }
}
