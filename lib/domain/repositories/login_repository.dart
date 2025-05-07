import 'package:yacht_reservation_frontend/domain/models/jwt.dart';

abstract class LoginRepository {
  Future<Jwt> login(String email, String password);
}
