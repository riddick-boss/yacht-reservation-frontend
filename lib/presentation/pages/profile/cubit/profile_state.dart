part of 'profile_cubit.dart';

@freezed
abstract class ProfileState with _$ProfileState {
  const factory ProfileState({
    final ProfileEffect? effect,
    @Default('John Doe') String userName,
    @Default('john.doe@email.com') String userEmail,
  }) = _ProfileState;
}

@freezed
sealed class ProfileEffect with _$ProfileEffect {
  const factory ProfileEffect.logout() = ProfileLogout;
}
