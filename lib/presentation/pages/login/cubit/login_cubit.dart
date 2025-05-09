import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:yacht_reservation_frontend/domain/services/auth_service.dart';

part 'login_state.dart';
part 'login_cubit.freezed.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final AuthService authService;

  LoginCubit(this.authService) : super(const LoginState());

  void emailChanged(String value) {
    emit(state.copyWith(email: value));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(password: value));
  }

  Future<void> login() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      await authService.login(state.email, state.password);
      emit(
        state.copyWith(isLoading: false, navDestination: NavDestination.home),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Login failed. Please try again.',
        ),
      );
    }
  }
}
