part of 'login_cubit.dart';

enum NavDestination { none, home }

@freezed
abstract class LoginState with _$LoginState {
  const factory LoginState({
    @Default('') String email,
    @Default('') String password,
    @Default(false) bool isLoading,
    @Default(false) bool isValid,
    String? errorMessage,
    @Default(NavDestination.none) NavDestination navDestination,
  }) = _LoginState;
}
