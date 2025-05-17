import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:injectable/injectable.dart';
import 'package:yacht_reservation_frontend/domain/services/auth_service.dart';

part 'splash_state.dart';

@injectable
class SplashCubit extends Cubit<SplashState> {
  final AuthService _authService;

  SplashCubit(this._authService) : super(const SplashState()) {
    _checkLogin();
  }

  Future<void> _checkLogin() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    final loggedIn = await _authService.isLoggedIn();
    emit(state.copyWith(
      status: loggedIn ? Status.authenticated : Status.unauthenticated,
    ));
  }
}
