part of 'splash_cubit.dart';

@freezed
abstract class SplashState with _$SplashState {
  const factory SplashState({@Default(Status.initial) Status status}) =
      _SplashState;
}

enum Status { initial, authenticated, unauthenticated }
