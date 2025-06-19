import 'package:freezed_annotation/freezed_annotation.dart';

part 'reservation.freezed.dart';

@freezed
abstract class Reservation with _$Reservation {
  const factory Reservation({
    required int id,
    required String yacht,
    required String location,
    required String date,
    required String image,
    @Default(false) bool isPast,
  }) = _Reservation;
}
