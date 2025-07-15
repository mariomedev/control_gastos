import 'dart:ui';

import '../../domain.dart';

class SetColorScheme {
  final ThemeRepo repositoty;

  SetColorScheme(this.repositoty);

  Future<void> call(Color colorScheme) async {
    await repositoty.setColorSheme(colorScheme);
  }
}
