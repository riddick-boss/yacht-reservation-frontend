import 'package:injectable/injectable.dart';
import 'package:yacht_reservation_frontend/data/datasource/login_remote_datasource.dart';
import 'package:yacht_reservation_frontend/domain/models/jwt.dart';
import 'package:yacht_reservation_frontend/domain/repositories/login_repository.dart';

@Injectable(as: LoginRepository)
class LoginRepositoryImpl implements LoginRepository {
  LoginRepositoryImpl({required this.loginRemoteDatasource});

  final LoginRemoteDatasource loginRemoteDatasource;

  @override
  Future<Jwt> login(String email, String password) async {
    return loginRemoteDatasource.login(email, password);
  }
}
