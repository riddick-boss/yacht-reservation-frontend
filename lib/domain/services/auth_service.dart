abstract class AuthService {
  Future<bool> isLoggedIn();
  Future<void> login(String email, String password);
  Future<void> register(String email, String password);
}
