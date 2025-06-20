import 'package:freezed_annotation/freezed_annotation.dart';

part 'promo.freezed.dart';

@freezed
abstract class PromoBanner with _$PromoBanner {
  const factory PromoBanner({
    required String title,
    required String message,
    required String buttonText,
  }) = _PromoBanner;
}

@freezed
abstract class PromoData with _$PromoData {
  const factory PromoData({
    required YachtPromo yacht,
    required String location,
    required int price,
    required List<String> availableDays,
  }) = _PromoData;
}

@freezed
abstract class YachtPromo with _$YachtPromo {
  const factory YachtPromo({
    required int id,
    required String name,
    required String imageUrl,
  }) = _YachtPromo;
}
