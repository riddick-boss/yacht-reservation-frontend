import 'package:dio/dio.dart';
import 'package:yacht_reservation_frontend/data/datasource/auth/auth_local_datasource.dart';
import 'package:injectable/injectable.dart';

@injectable
class JwtInterceptor extends Interceptor {
  final AuthLocalDatasource authLocalDatasource;

  JwtInterceptor(this.authLocalDatasource);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final jwt = authLocalDatasource.getJwt();
    if (jwt != null) {
      options.headers['Authorization'] = 'Bearer $jwt';
    }
    super.onRequest(options, handler);
  }
}
