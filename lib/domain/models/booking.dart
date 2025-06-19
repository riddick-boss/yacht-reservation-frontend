import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking.freezed.dart';

@freezed
abstract class Booking with _$Booking {
  const factory Booking({
    required int id,
    required String yachtName,
    required String day,
    required String locationName,
    required String locationImageUrl,
  }) = _Booking;
}
