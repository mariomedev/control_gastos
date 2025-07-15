import '../../domain.dart';

class GetDarkMode {
  final ThemeRepo repository;

  GetDarkMode(this.repository);

  Future<bool> call() async {
    return await repository.getIsDarkMode();
  }
}
