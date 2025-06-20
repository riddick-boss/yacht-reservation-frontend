import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:yacht_reservation_frontend/data/datasource/promo/dto/promo_response.dart';

@injectable
class PromoRemoteDatasource {
  final Dio dio;

  PromoRemoteDatasource(this.dio);

  Future<PromoBannerResponse> getPromoBanner() async {
    final response = await dio.get('/promotion/banner');
    return PromoBannerResponse.fromJson(response.data);
  }

  Future<PromoDataResponse> getPromoData() async {
    final response = await dio.get('/promotion');
    return PromoDataResponse.fromJson(response.data);
  }
}
