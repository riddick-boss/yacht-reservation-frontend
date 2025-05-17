abstract class AuthService {
  Future<void> login(String email, String password);
  Future<void> register(String email, String password);
  Future<bool> isLoggedIn();
  Future<void> logout();
}
