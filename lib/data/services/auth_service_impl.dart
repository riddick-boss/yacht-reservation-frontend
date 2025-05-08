import 'package:injectable/injectable.dart';
import 'package:yacht_reservation_frontend/data/datasource/auth/auth_remote_datasource.dart';
import 'package:yacht_reservation_frontend/domain/services/auth_service.dart';
import 'package:yacht_reservation_frontend/domain/util/app_logger.dart';

@Injectable(as: AuthService)
class AuthServiceImpl implements AuthService {
  final AuthRemoteDatasource _loginRemoteDatasource;

  AuthServiceImpl(this._loginRemoteDatasource);

  @override
  Future<bool> isLoggedIn() async {
    try {
      final isJwtValid = await _loginRemoteDatasource.validateJwt();
      return isJwtValid;
    } catch (e) {
      AppLogger.e('Error validating JWT: $e');
      return false;
    }
  }

  @override
  Future<void> login(String email, String password) async {
    // TODO: implement login
  }
}
