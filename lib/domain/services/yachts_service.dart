import 'package:yacht_reservation_frontend/domain/models/yacht.dart';

abstract class YachtsService {
  Future<List<Yacht>> getYachts();
  Future<List<Yacht>> getFeaturedYachts();
}
