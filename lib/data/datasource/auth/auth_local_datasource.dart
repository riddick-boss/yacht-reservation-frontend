import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class AuthLocalDatasource {
  final SharedPreferences _prefs;
  static const _jwtKey = 'jwt_token';

  AuthLocalDatasource(this._prefs);

  Future<void> saveJwt(String jwt) async {
    await _prefs.setString(_jwtKey, jwt);
  }

  String? getJwt() => _prefs.getString(_jwtKey);

  Future<void> deleteJwt() async {
    await _prefs.remove(_jwtKey);
  }

  Future<void> clearAll() async {
    await _prefs.clear();
  }
}
