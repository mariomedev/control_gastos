import 'package:control_gastos/core/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/domain.dart';
import '../../../infrastructure/infrastruture.dart';

final themeRepositoyProvider = Provider<ThemeRepo>((ref) {
  final dataSource = DataThemeImpl(service: SharedPreferencesServiceImpl());

  return ThemeRepoImpl(dataSource: dataSource);
});
