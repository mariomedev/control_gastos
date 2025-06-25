abstract class AuthRepository {
  Future<void> singIn(String email, String password);
  Future<void> signUp(String email, String password);
}
