import 'package:injectable/injectable.dart';
import 'package:yacht_reservation_frontend/data/datasource/promo/dto/promo_response.dart';
import 'package:yacht_reservation_frontend/data/datasource/promo/promo_remote_datasource.dart';
import 'package:yacht_reservation_frontend/domain/models/promo.dart';
import 'package:yacht_reservation_frontend/domain/services/promo_service.dart';

@Injectable(as: PromoService)
class PromoServiceImpl implements PromoService {
  final PromoRemoteDatasource promoRemoteDatasource;
  final PromoMapper promoMapper;

  PromoServiceImpl(this.promoRemoteDatasource, this.promoMapper);

  @override
  Future<PromoBanner> getPromoBanner() async {
    final response = await promoRemoteDatasource.getPromoBanner();
    return promoMapper.toPromoBanner(response);
  }

  @override
  Future<PromoData> getPromoData() async {
    final response = await promoRemoteDatasource.getPromoData();
    return promoMapper.toPromoData(response);
  }
}

@injectable
class PromoMapper {
  PromoBanner toPromoBanner(PromoBannerResponse response) {
    return PromoBanner(
      title: response.title,
      message: response.message,
      buttonText: response.buttonText,
    );
  }

  PromoData toPromoData(PromoDataResponse response) {
    return PromoData(
      yacht: YachtPromo(
        id: response.yacht.id,
        name: response.yacht.name,
        imageUrl: response.yacht.imageUrl,
      ),
      location: response.location,
      price: response.price,
      availableDays: response.availableDays,
    );
  }
}
