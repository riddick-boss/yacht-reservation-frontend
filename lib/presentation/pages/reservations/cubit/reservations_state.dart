part of 'reservations_cubit.dart';

@freezed
sealed class ReservationsState with _$ReservationsState {
  const factory ReservationsState.loading() = Loading;
  const factory ReservationsState.loaded({
    required List<Reservation> upcoming,
    required List<Reservation> past,
  }) = Loaded;
  const factory ReservationsState.error(String message) = Error;
}
