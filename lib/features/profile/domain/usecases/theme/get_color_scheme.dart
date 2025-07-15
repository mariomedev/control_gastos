import 'dart:ui';

import '../../domain.dart';

class GetColorScheme {
  final ThemeRepo repository;

  GetColorScheme(this.repository);

  Future<Color> call() async {
    return await repository.getColorScheme();
  }
}
