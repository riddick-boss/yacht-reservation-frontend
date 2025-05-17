import '../models/jwt.dart';

abstract class AuthService {
  Future<Jwt> login(String username, String password);

  register(String email, String password) {}

  isLoggedIn() {}
}
