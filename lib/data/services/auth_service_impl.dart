import 'package:injectable/injectable.dart';
import 'package:yacht_reservation_frontend/domain/services/auth_service.dart';

@Injectable(as: AuthService)
class AuthServiceImpl implements AuthService {
  @override
  Future<bool> isLoggedIn() async {
    return Future.delayed(
      const Duration(seconds: 2),
      () => false,
    ); //TODO: check if jwtToken present and make api call to validate it
  }

  @override
  Future<void> login(String email, String password) async {
    // TODO: implement login
  }
}
