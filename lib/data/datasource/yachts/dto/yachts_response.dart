import 'package:freezed_annotation/freezed_annotation.dart';

part 'yachts_response.freezed.dart';
part 'yachts_response.g.dart';

@freezed
abstract class YachtResponse with _$YachtResponse {
  const factory YachtResponse({
    required int id,
    required String name,
    required String manufacturer,
    required double length,
    required int crewNum,
    required int pricePerDay,
    required String imageUrl,
    required bool isAvailable,
  }) = _YachtResponse;

  factory YachtResponse.fromJson(Map<String, dynamic> json) =>
      _$YachtResponseFromJson(json);
}

@freezed
abstract class YachtsResponse with _$YachtsResponse {
  const factory YachtsResponse({required List<YachtResponse> list}) =
      _YachtsResponse;

  factory YachtsResponse.fromJson(Map<String, dynamic> json) =>
      _$YachtsResponseFromJson(json);
}

@freezed
abstract class YachtLocationResponse with _$YachtLocationResponse {
  const factory YachtLocationResponse({
    required int id,
    required String name,
    required double latitude,
    required double longitude,
  }) = _YachtLocationResponse;

  factory YachtLocationResponse.fromJson(Map<String, dynamic> json) =>
      _$YachtLocationResponseFromJson(json);
}

@freezed
abstract class YachtsLocationsResponse with _$YachtsLocationsResponse {
  const factory YachtsLocationsResponse({
    required List<YachtLocationResponse> list,
  }) = _YachtsLocationsResponse;

  factory YachtsLocationsResponse.fromJson(Map<String, dynamic> json) =>
      _$YachtsLocationsResponseFromJson(json);
}
