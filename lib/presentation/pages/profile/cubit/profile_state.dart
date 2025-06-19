part of 'profile_cubit.dart';

@freezed
abstract class ProfileState with _$ProfileState {
  const factory ProfileState({final ProfileEffect? effect}) = _ProfileState;
}

@freezed
sealed class ProfileEffect with _$ProfileEffect {
  const factory ProfileEffect.logout() = ProfileLogout;
}
