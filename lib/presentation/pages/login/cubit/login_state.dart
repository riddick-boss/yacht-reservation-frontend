part of 'login_cubit.dart';

@freezed
abstract class LoginState with _$LoginState {
  const factory LoginState({
    @Default('') String email,
    @Default('') String password,
    @Default(false) bool isLoading,
    @Default(false) bool isValid,
    String? errorMessage,
    String? emailError,
    String? passwordError,
  }) = _LoginState;
}
