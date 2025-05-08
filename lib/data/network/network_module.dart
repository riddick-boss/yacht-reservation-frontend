import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';

@module
abstract class NetworkModule {
  @singleton
  Dio provideDio() {
    return Dio(
      BaseOptions(
        baseUrl: 'http://localhost:8080', // TODO: change once backend is ready
        connectTimeout: const Duration(seconds: 120),
        receiveTimeout: const Duration(seconds: 120),
      ),
    );
  }
}
