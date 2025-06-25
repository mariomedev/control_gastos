import '../../domain/domain.dart';

class AuthSupabaseImpl extends AuthDataSource {
  @override
  Future<void> signUp(String email, String password) {
    throw UnimplementedError();
  }

  @override
  Future<void> singIn(String email, String password) {
    throw UnimplementedError();
  }
}
