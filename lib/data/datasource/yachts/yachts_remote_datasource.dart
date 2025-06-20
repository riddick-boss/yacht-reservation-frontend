import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'dto/yachts_response.dart';

@injectable
class YachtsRemoteDatasource {
  final Dio dio;

  YachtsRemoteDatasource(this.dio);

  Future<List<YachtResponse>> getYachts() async {
    final response = await dio.get('/yachts/all');
    return YachtsResponse.fromJson(response.data).list;
  }

  Future<List<YachtResponse>> getFeaturedYachts() async {
    final response = await dio.get('/yachts/featured');
    return YachtsResponse.fromJson(response.data).list;
  }

  Future<List<YachtLocationResponse>> getYachtsLocations() async {
    final response = await dio.get('/yachts/locations');
    return YachtsLocationsResponse.fromJson(response.data).list;
  }
}
