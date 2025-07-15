import 'package:flutter/widgets.dart';

import '../../domain/domain.dart';

class ThemeRepoImpl implements ThemeRepo {
  final ThemeDataDomain dataSource;

  ThemeRepoImpl({required this.dataSource});

  @override
  Future<Color> getColorScheme() async {
    return dataSource.getColorScheme();
  }

  @override
  Future<bool> getIsDarkMode() {
    return dataSource.getIsDarkMode();
  }

  @override
  Future<void> setColorSheme(Color colorScheme) {
    return dataSource.setColorSheme(colorScheme);
  }

  @override
  Future<void> setIsDarkMode(bool isDarkMode) {
    return dataSource.setIsDarkMode(isDarkMode);
  }
}
