import 'package:freezed_annotation/freezed_annotation.dart';

part 'yacht.freezed.dart';

@freezed
abstract class Yacht with _$Yacht {
  const factory Yacht({
    required int id,
    required String name,
    required String manufacturer,
    required int length,
    required int crewNum,
    required int price,
  }) = _Yacht;
}
