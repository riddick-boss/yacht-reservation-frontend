abstract class AuthService {
  Future<bool> isLoggedIn();
  Future<void> login(String email, String password);
}
