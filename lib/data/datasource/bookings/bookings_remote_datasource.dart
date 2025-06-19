import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';
import 'package:yacht_reservation_frontend/data/datasource/bookings/dto/bookings_response.dart';

@injectable
class BookingsRemoteDatasource {
  final Dio dio;

  BookingsRemoteDatasource(this.dio);

  Future<void> book(int yachtId, String day) async {
    await dio.get('/bookings/book', data: {'yachtId': yachtId, 'day': day});
  }

  Future<void> cancel(int bookingId) async {
    await dio.delete('/bookings/$bookingId');
  }

  Future<List<BookingResponse>> getUpcomingBookings() async {
    final response = await dio.get('/bookings/upcoming');
    return BookingsResponse.fromJson(response.data).list;
  }

  Future<List<BookingResponse>> getPastBookings() async {
    final response = await dio.get('/bookings/past');
    return BookingsResponse.fromJson(response.data).list;
  }
}
