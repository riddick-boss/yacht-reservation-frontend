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
}
