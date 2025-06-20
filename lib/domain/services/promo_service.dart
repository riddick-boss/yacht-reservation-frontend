import 'package:yacht_reservation_frontend/domain/models/promo.dart';

abstract class PromoService {
  Future<PromoBanner> getPromoBanner();
  Future<PromoData> getPromoData();
}
