part of 'login_cubit.dart';

enum NavDestination { none, home }

class LoginState {
  final String email;
  final String password;
  final bool isLoading;
  final String? errorMessage;
  final NavDestination navDestination;

  const LoginState({
    this.email = '',
    this.password = '',
    this.isLoading = false,
    this.errorMessage,
    this.navDestination = NavDestination.none,
  });

  LoginState copyWith({
    String? email,
    String? password,
    bool? isLoading,
    String? errorMessage,
    NavDestination? navDestination,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      navDestination: navDestination ?? this.navDestination,
    );
  }
}
