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
