import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../domain/domain.dart';

class DataThemeImpl implements ThemeDataDomain {
  final SharedPreferencesService service;

  DataThemeImpl({required this.service});

  static const int _defaultColorInt = 0xFF42A5F5;

  @override
  Future<void> setColorSheme(Color colorScheme) async {
    final value = colorScheme.toARGB32();
    await service.saveInt(AppPrefsKeys.colorSheme, value);
  }

  @override
  Future<Color> getColorScheme() async {
    final colorInt =
        await service.getInt(AppPrefsKeys.colorSheme) ?? _defaultColorInt;
    final color = Color(colorInt);
    return color;
  }

  @override
  Future<void> setIsDarkMode(bool isDarkMode) async {
    await service.saveBool(AppPrefsKeys.isDarkMode, isDarkMode);
  }

  @override
  Future<bool> getIsDarkMode() async {
    return await service.getBool(AppPrefsKeys.isDarkMode) ?? false;
  }
}
