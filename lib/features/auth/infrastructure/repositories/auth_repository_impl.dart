import '../../domain/domain.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDataSource authDataSource;
  AuthRepositoryImpl({required this.authDataSource});
  @override
  Future<void> signUp(String email, String password) {
    return authDataSource.signUp(email, password);
  }

  @override
  Future<void> singIn(String email, String password) {
    return authDataSource.singIn(email, password);
  }
}
