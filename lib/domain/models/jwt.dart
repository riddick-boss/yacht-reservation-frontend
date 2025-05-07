import 'package:freezed_annotation/freezed_annotation.dart';

part 'jwt.freezed.dart';

@freezed
abstract class Jwt with _$Jwt {
  const factory Jwt({required String jwt}) = _Jwt;
}
