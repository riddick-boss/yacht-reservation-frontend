import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:yacht_reservation_frontend/data/datasource/dto/login_response.dart';
import 'package:yacht_reservation_frontend/domain/models/jwt.dart';
import 'package:yacht_reservation_frontend/domain/util/app_logger.dart';

@injectable
class LoginRemoteDatasource {
  LoginRemoteDatasource({required this.dio});

  final Dio dio;

  Future<Jwt> login(String email, String password) async {
    //TODO: implement login api call
    final response = LoginResponse(jwt: '');
    AppLogger.i('login response: $response');
    return Jwt(jwt: response.jwt);
  }
}
