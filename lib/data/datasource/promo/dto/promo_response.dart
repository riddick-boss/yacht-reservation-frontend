import 'package:freezed_annotation/freezed_annotation.dart';

part 'promo_response.freezed.dart';
part 'promo_response.g.dart';

@freezed
abstract class PromoBannerResponse with _$PromoBannerResponse {
  const factory PromoBannerResponse({
    required String title,
    required String message,
    required String buttonText,
  }) = _PromoBannerResponse;

  factory PromoBannerResponse.fromJson(Map<String, dynamic> json) =>
      _$PromoBannerResponseFromJson(json);
}

@freezed
abstract class PromoDataResponse with _$PromoDataResponse {
  const factory PromoDataResponse({
    required YachtPromoDto yacht,
    required String location,
    required int price,
    required List<String> availableDays,
  }) = _PromoDataResponse;

  factory PromoDataResponse.fromJson(Map<String, dynamic> json) =>
      _$PromoDataResponseFromJson(json);
}

@freezed
abstract class YachtPromoDto with _$YachtPromoDto {
  const factory YachtPromoDto({
    required int id,
    required String name,
    required String imageUrl,
  }) = _YachtPromoDto;

  factory YachtPromoDto.fromJson(Map<String, dynamic> json) =>
      _$YachtPromoDtoFromJson(json);
}
