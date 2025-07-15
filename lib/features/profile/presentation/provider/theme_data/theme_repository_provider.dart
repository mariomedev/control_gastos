import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/core.dart';
import '../../../domain/domain.dart';
import '../../../infrastructure/infrastruture.dart';

final themeRepositoyProvider = Provider<ThemeRepo>((ref) {
  final dataSource = DataThemeImpl(service: SharedPreferencesServiceImpl());

  return ThemeRepoImpl(dataSource: dataSource);
});
