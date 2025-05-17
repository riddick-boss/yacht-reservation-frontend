part of 'splash_cubit.dart';

enum Status { initial, authenticated, unauthenticated }

class SplashState {
  final Status status;
  const SplashState({this.status = Status.initial});

  SplashState copyWith({Status? status}) {
    return SplashState(status: status ?? this.status);
  }
}

