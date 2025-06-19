import 'package:yacht_reservation_frontend/domain/models/booking.dart';

abstract class BookingsService {
  Future<List<Booking>> getUpcomingBookings();
  Future<List<Booking>> getPastBookings();
  Future<void> book(int yachtId, String day);
  Future<void> cancel(int bookingId);
}
