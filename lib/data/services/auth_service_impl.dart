import 'package:dio/dio.dart';
import '../../domain/models/jwt.dart';
import '../../domain/services/auth_service.dart';

abstract class AuthServiceImpl implements AuthService {
  final Dio _dio;

  AuthServiceImpl(this._dio);

  @override
  Future<Jwt> login(String username, String password) async {
    try {
      final response = await _dio.post('/auth/login', data: {
        'username': username,
        'password': password,
      });

      if (response.statusCode == 200) {
        return Jwt.fromJson(response.data);
      } else {
        throw Exception('Błąd logowania: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      final message = e.response?.data?['message'] ?? 'Błąd logowania';
      throw Exception(message);
    } catch (e) {
      throw Exception('Nieoczekiwany błąd: $e');
    }
  }

  @override
  Future<Jwt> register(String username, String password) async {
    try {
      final response = await _dio.post('/auth/register', data: {
        'username': username,
        'password': password,
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Jwt.fromJson(response.data);
      } else {
        throw Exception('Błąd rejestracji: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      final message = e.response?.data?['message'] ?? 'Błąd rejestracji';
      throw Exception(message);
    } catch (e) {
      throw Exception('Nieoczekiwany błąd: $e');
    }
  }
}
