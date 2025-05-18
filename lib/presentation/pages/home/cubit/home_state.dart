part of 'home_cubit.dart';

@freezed
abstract class HomeState with _$HomeState {
  const factory HomeState({
    @Default(false) bool isLoading,
    @Default([]) List<Yacht> yachts,
  }) = _HomeState;
}
