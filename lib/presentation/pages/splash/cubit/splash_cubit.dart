import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:yacht_reservation_frontend/domain/services/auth_service.dart';

part 'splash_state.dart';
part 'splash_cubit.freezed.dart';

@injectable
class SplashCubit extends Cubit<SplashState> {
  SplashCubit(this.authService) : super(const SplashState()) {
    _checkLogin();
  }

  final AuthService authService;

  Future<void> _checkLogin() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    final isLoggedIn = await authService.isLoggedIn();
    emit(
      state.copyWith(
        status: isLoggedIn ? Status.authenticated : Status.unauthenticated,
      ),
    );
  }
}
