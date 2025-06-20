part of 'home_cubit.dart';

@freezed
abstract class HomeState with _$HomeState {
  const factory HomeState({
    @Default(false) bool isLoading,
    @Default([]) List<Yacht> yachts,
    @Default([]) List<Booking> upcomingBookings,
    @Default('') String userName,
    @Default(null) PromoBanner? promoBanner,
    @Default(null) PromoData? promoData,
    @Default([]) List<YachtLocation> yachtsLocations,
  }) = _HomeState;
}
