import 'package:freezed_annotation/freezed_annotation.dart';

part 'yacht.freezed.dart';

@freezed
abstract class Yacht with _$Yacht {
  const factory Yacht({
    required int id,
    required String name,
    required String manufacturer,
    required double length,
    required int crewNum,
    required int price,
    required String imageUrl,
    required bool isAvailable,
  }) = _Yacht;
}

@freezed
abstract class YachtLocation with _$YachtLocation {
  const factory YachtLocation({
    required int id,
    required String name,
    required double latitude,
    required double longitude,
  }) = _YachtLocation;
}
