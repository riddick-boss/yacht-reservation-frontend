import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import '../../data/services/auth_service_impl.dart';
import '../services/auth_service.dart';

final getIt = GetIt.instance;

void configureDependencies() {
  getIt.registerLazySingleton<Dio>(() => Dio(BaseOptions(
        baseUrl: 'https://api.example.com',
      )));
  getIt.registerLazySingleton<AuthService>(() => AuthServiceImpl(getIt<Dio>()));
}
