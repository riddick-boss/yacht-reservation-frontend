import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:yacht_reservation_frontend/data/datasource/auth/auth_local_datasource.dart';
import 'package:yacht_reservation_frontend/data/datasource/auth/dto/login_response.dart';
import 'package:yacht_reservation_frontend/domain/models/jwt.dart';
import 'package:yacht_reservation_frontend/domain/util/app_logger.dart';

@injectable
class AuthRemoteDatasource {
  final Dio dio;
  final AuthLocalDatasource authLocalDatasource;

  AuthRemoteDatasource(this.dio, this.authLocalDatasource);

  Future<bool> validateJwt() async {
    return Future.delayed(
      const Duration(seconds: 5),
      () => false,
    ); //TODO: remove once endpoint ready, added just for testing

    final jwt = authLocalDatasource.getJwt();
    if (jwt == null) {
      return false;
    }
    final response = await dio.get('/auth/validate-jwt');
    return response.statusCode == 200;
  }

  Future<Jwt> login(String email, String password) async {
    //TODO: implement login api call
    final response = LoginResponse(jwt: '');
    AppLogger.i('login response: $response');
    return Jwt(jwt: response.jwt);
  }
}
