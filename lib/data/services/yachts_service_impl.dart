import 'package:injectable/injectable.dart';
import 'package:yacht_reservation_frontend/data/datasource/yachts/dto/yachts_response.dart';
import 'package:yacht_reservation_frontend/domain/models/yacht.dart';
import 'package:yacht_reservation_frontend/domain/services/yachts_service.dart';
import 'package:yacht_reservation_frontend/data/datasource/yachts/yachts_remote_datasource.dart';

@Injectable(as: YachtsService)
class YachtsServiceImpl implements YachtsService {
  final YachtsRemoteDatasource _yachtsRemoteDatasource;
  final YachtMapper _yachtMapper;

  YachtsServiceImpl(this._yachtsRemoteDatasource, this._yachtMapper);

  @override
  Future<List<Yacht>> getYachts() async {
    final yachtsResponse = await _yachtsRemoteDatasource.getYachts();
    return _yachtMapper.toYachtList(yachtsResponse);
  }
}

@injectable
class YachtMapper {
  List<Yacht> toYachtList(List<YachtResponse> response) =>
      response.map((yachtResponse) => toYacht(yachtResponse)).toList();

  Yacht toYacht(YachtResponse response) => Yacht(
    id: response.id,
    name: response.name,
    manufacturer: response.manufacturer,
    length: response.length,
    crewNum: response.crewNum,
    price: response.price,
    isAvailable: response.isAvailable,
  );
}
