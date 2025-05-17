import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';
import 'package:yacht_reservation_frontend/data/network/jwt_interceptor.dart';

@module
abstract class NetworkModule {
  @singleton
  Dio provideDio(JwtInterceptor jwtInterceptor) {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://yacht-reservation-backend.onrender.com',
        connectTimeout: const Duration(seconds: 120),
        receiveTimeout: const Duration(seconds: 120),
      ),
    );

    // Add interceptors
    dio.interceptors.addAll([
      jwtInterceptor,
      LogInterceptor(requestBody: true, responseBody: true),
    ]);

    return dio;
  }
}
