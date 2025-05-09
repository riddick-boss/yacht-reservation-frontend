import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:yacht_reservation_frontend/data/datasource/auth/dto/login_response.dart';
import 'package:yacht_reservation_frontend/domain/util/app_logger.dart';

@injectable
class AuthRemoteDatasource {
  final Dio dio;

  AuthRemoteDatasource(this.dio);

  Future<bool> validateJwt() async {
    return Future.delayed(
      const Duration(seconds: 5),
      () => false,
    ); //TODO: remove once endpoint ready, added just for testing
    final response = await dio.get('/auth/validate-jwt');
    return response.statusCode == 200;
  }

  Future<LoginResponse> login(String email, String password) async {
    return Future.delayed(
      const Duration(seconds: 4),
      () => LoginResponse(jwt: 'sampleJwtToken'),
    ); // TODO: remove once endpoint ready, added just for testing
    final response = await dio.post(
      '/auth/login',
      data: {'email': email, 'password': password},
    );
    AppLogger.i('login response: $response');
    return LoginResponse.fromJson(response.data);
  }
}
