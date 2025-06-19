part of 'reservations_cubit.dart';

@freezed
sealed class ReservationsState with _$ReservationsState {
  const factory ReservationsState.loading() = Loading;
  const factory ReservationsState.loaded({
    required List<Booking> upcoming,
    required List<Booking> past,
  }) = Loaded;
  const factory ReservationsState.error(String message) = Error;
}
