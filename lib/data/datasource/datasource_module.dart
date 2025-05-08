import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class DatasourceModule {
  // @singleton
  // FlutterSecureStorage get secureStorage => const FlutterSecureStorage();

  @preResolve
  @singleton
  Future<SharedPreferences> get sharedPreferences =>
      SharedPreferences.getInstance();
}
