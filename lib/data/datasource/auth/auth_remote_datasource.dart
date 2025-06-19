import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:yacht_reservation_frontend/data/datasource/auth/dto/login_response.dart';
import 'package:yacht_reservation_frontend/data/datasource/auth/dto/profile_response.dart';
import 'package:yacht_reservation_frontend/data/datasource/auth/dto/register_response.dart';
import 'package:yacht_reservation_frontend/domain/util/app_logger.dart';

@injectable
class AuthRemoteDatasource {
  final Dio dio;

  AuthRemoteDatasource(this.dio);

  Future<bool> validateJwt() async {
    // return Future.delayed(
    //   const Duration(seconds: 5),
    //   () => false,
    // );
    final response = await dio.get('/auth/validate-token');
    return response.statusCode == 200;
  }

  Future<LoginResponse> login(String email, String password) async {
    // return Future.delayed(
    //   const Duration(seconds: 4),
    //   () => LoginResponse(jwt: 'sampleJwtToken'),
    // );
    final response = await dio.post(
      '/auth/login',
      data: {'email': email, 'password': password},
    );
    AppLogger.i('login response: $response');
    return LoginResponse.fromJson(response.data);
  }

  Future<RegisterResponse> register(String email, String password) async {
    final response = await dio.post(
      '/auth/register',
      data: {'email': email, 'password': password},
    );
    AppLogger.i('register response: $response');
    return RegisterResponse.fromJson(response.data);
  }

  Future<ProfileResponse> getProfile() async {
    final response = await dio.get('/profile');
    AppLogger.i('get profile response: $response');
    return ProfileResponse.fromJson(response.data['profile']);
  }

  Future<ProfileResponse> updateProfile(String name) async {
    final response = await dio.post('/profile', data: {'name': name});
    AppLogger.i('update profile response: $response');
    return ProfileResponse.fromJson(response.data['profile']);
  }
}
