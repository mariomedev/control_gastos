import '../../domain.dart';

class SetDarkMode {
  final ThemeRepo repository;

  SetDarkMode(this.repository);

  Future<void> call(bool isDarkMode) async {
    await repository.setIsDarkMode(isDarkMode);
  }
}
