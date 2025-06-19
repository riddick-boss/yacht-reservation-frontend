import 'package:injectable/injectable.dart';
import 'package:yacht_reservation_frontend/data/datasource/auth/auth_local_datasource.dart';
import 'package:yacht_reservation_frontend/data/datasource/auth/auth_remote_datasource.dart';
import 'package:yacht_reservation_frontend/domain/services/auth_service.dart';
import 'package:yacht_reservation_frontend/domain/util/app_logger.dart';

@Injectable(as: AuthService)
class AuthServiceImpl implements AuthService {
  final AuthRemoteDatasource _loginRemoteDatasource;
  final AuthLocalDatasource _authLocalDatasource;

  AuthServiceImpl(this._loginRemoteDatasource, this._authLocalDatasource);

  @override
  Future<bool> isLoggedIn() async {
    try {
      final jwt = _authLocalDatasource.getJwt();
      if (jwt == null) {
        AppLogger.i('No JWT found');
        return false;
      }
      final isJwtValid = await _loginRemoteDatasource.validateJwt();
      return isJwtValid;
    } catch (e) {
      AppLogger.e('Error validating JWT: $e');
      return false;
    }
  }

  @override
  Future<void> login(String email, String password) async {
    final loginResponse = await _loginRemoteDatasource.login(email, password);
    _authLocalDatasource.saveJwt(loginResponse.jwtToken);
  }

  @override
  Future<void> register(String email, String password) async {
    final registerResponse = await _loginRemoteDatasource.register(
      email,
      password,
    );
    _authLocalDatasource.saveJwt(registerResponse.jwtToken);
  }

  @override
  Future<void> logout() async {
    await _authLocalDatasource.deleteJwt();
  }
}
