import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:yacht_reservation_frontend/data/datasource/auth/dto/login_response.dart';
import 'package:yacht_reservation_frontend/data/datasource/auth/dto/register_response.dart';
import 'package:yacht_reservation_frontend/domain/util/app_logger.dart';

@injectable
class AuthRemoteDatasource {
  final Dio _dio;

  AuthRemoteDatasource(this._dio);

  Future<bool> validateJwt() async {
    try {
      final response = await _dio.get('/auth/validate-token');
      AppLogger.i('validateJwt response: ${response.statusCode}');
      return response.statusCode == 200;
    } catch (e, stack) {
      AppLogger.e('validateJwt error: $e', error: e, stackTrace: stack);
      return false;
    }
  }

  Future<LoginResponse> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '/auth/login',
        data: {'email': email, 'password': password},
      );
      AppLogger.i('login response: ${response.data}');
      return LoginResponse.fromJson(response.data);
    } catch (e, stack) {
      AppLogger.e('Login failed: $e', error: e, stackTrace: stack);
      rethrow;
    }
  }

  Future<RegisterResponse> register(String email, String password) async {
    try {
      final response = await _dio.post(
        '/auth/register',
        data: {'email': email, 'password': password},
      );
      AppLogger.i('register response: ${response.data}');
      return RegisterResponse.fromJson(response.data);
    } catch (e, stack) {
      AppLogger.e('Registration failed: $e', error: e, stackTrace: stack);
      rethrow;
    }
  }
}
