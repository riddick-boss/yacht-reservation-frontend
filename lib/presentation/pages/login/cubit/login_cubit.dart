import 'package:bloc/bloc.dart';
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
    final emailError = _validateEmail(value);
    emit(
      state.copyWith(
        email: value,
        emailError: emailError,
        isValid: _isFormValid(
          value,
          state.password,
          emailError,
          state.passwordError,
        ),
      ),
    );
  }

  void passwordChanged(String value) {
    final passwordError = _validatePassword(value);
    emit(
      state.copyWith(
        password: value,
        passwordError: passwordError,
        isValid: _isFormValid(
          state.email,
          value,
          state.emailError,
          passwordError,
        ),
      ),
    );
  }

  Future<void> login() async {
    if (!state.isValid) return;

    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      //TODO: call login api
      // Handle successful login (e.g., navigate to home)
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  String? _validateEmail(String email) {
    if (email.isEmpty) return 'Email is required';
    if (!email.contains('@')) return 'Invalid email format';
    return null;
  }

  String? _validatePassword(String password) {
    if (password.isEmpty) return 'Password is required';
    if (password.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  bool _isFormValid(
    String email,
    String password,
    String? emailError,
    String? passwordError,
  ) {
    return email.isNotEmpty &&
        password.isNotEmpty &&
        emailError == null &&
        passwordError == null;
  }
}
