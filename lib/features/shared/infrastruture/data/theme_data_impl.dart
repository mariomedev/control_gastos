import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../domain/domain.dart';

class DataThemeImpl implements ThemeDataDomain {
  final SharedPreferencesService service;

  DataThemeImpl({required this.service});

  static const int _defaultColorInt = 0xFF42A5F5;

  @override
  Future<Color> getColorScheme(String key) async {
    final colorInt = await service.getInt(key) ?? _defaultColorInt;
    final color = Color(colorInt);
    return color;
  }

  @override
  Future<bool> getIsDarkMode(String key) async {
    return await service.getBool(key) ?? false;
  }

  @override
  Future<void> setColorSheme(int colorScheme, String key) async {
    await service.saveInt(key, colorScheme);
  }

  @override
  Future<void> setIsDarkMode(bool isDarkMode, String key) async {
    await service.saveBool(key, isDarkMode);
  }
}
