import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:yacht_reservation_frontend/domain/services/auth_service.dart';

part 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final AuthService _authService;

  LoginCubit(this._authService) : super(const LoginState());

  void emailChanged(String email) => emit(state.copyWith(email: email));

  void passwordChanged(String password) => emit(state.copyWith(password: password));

  Future<void> login() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      await _authService.login(state.email, state.password);
      emit(state.copyWith(isLoading: false, navDestination: NavDestination.home));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: 'Login failed. Try again.'));
    }
  }

  Future<void> register() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      await _authService.register(state.email, state.password);
      emit(state.copyWith(isLoading: false, navDestination: NavDestination.home));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: 'Registration failed. Try again.'));
    }
  }

  void clearError() => emit(state.copyWith(errorMessage: null));

  void resetNavigation() => emit(state.copyWith(navDestination: NavDestination.none));
}
