import 'package:yacht_reservation_frontend/domain/models/profile.dart';

abstract class AuthService {
  Future<bool> isLoggedIn();
  Future<void> login(String email, String password);
  Future<void> register(String email, String password);
  Future<void> logout();
  Future<Profile> getProfile();
  Future<Profile> updateProfile(String name);
}
