part of 'profile_cubit.dart';

@freezed
abstract class ProfileState with _$ProfileState {
  const factory ProfileState({
    final ProfileEffect? effect,
    final Profile? profile,
  }) = _ProfileState;
}

@freezed
sealed class ProfileEffect with _$ProfileEffect {
  const factory ProfileEffect.logout() = ProfileLogout;
}
