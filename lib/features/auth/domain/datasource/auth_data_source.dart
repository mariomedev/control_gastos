abstract class AuthDataSource {
  Future<void> singIn(String email, String password);
  Future<void> signUp(String email, String password);
}
