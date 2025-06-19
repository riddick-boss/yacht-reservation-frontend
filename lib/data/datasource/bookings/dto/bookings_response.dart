import 'package:freezed_annotation/freezed_annotation.dart';

part 'bookings_response.freezed.dart';
part 'bookings_response.g.dart';

@freezed
abstract class BookingResponse with _$BookingResponse {
  const factory BookingResponse({
    required int id,
    required YachtBookingDto yacht,
    required String day,
    required BookingLocationDto location,
  }) = _BookingResponse;

  factory BookingResponse.fromJson(Map<String, dynamic> json) =>
      _$BookingResponseFromJson(json);
}

@freezed
abstract class BookingsResponse with _$BookingsResponse {
  const factory BookingsResponse({required List<BookingResponse> list}) =
      _BookingsResponse;

  factory BookingsResponse.fromJson(Map<String, dynamic> json) =>
      _$BookingsResponseFromJson(json);
}

@freezed
abstract class YachtBookingDto with _$YachtBookingDto {
  const factory YachtBookingDto({required String name}) = _YachtBookingDto;

  factory YachtBookingDto.fromJson(Map<String, dynamic> json) =>
      _$YachtBookingDtoFromJson(json);
}

@freezed
abstract class BookingLocationDto with _$BookingLocationDto {
  const factory BookingLocationDto({
    required String name,
    required String imageUrl,
  }) = _BookingLocationDto;

  factory BookingLocationDto.fromJson(Map<String, dynamic> json) =>
      _$BookingLocationDtoFromJson(json);
}
