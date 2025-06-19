import 'package:injectable/injectable.dart';
import 'package:yacht_reservation_frontend/data/datasource/bookings/bookings_remote_datasource.dart';
import 'package:yacht_reservation_frontend/data/datasource/bookings/dto/bookings_response.dart';
import 'package:yacht_reservation_frontend/domain/models/booking.dart';
import 'package:yacht_reservation_frontend/domain/services/bookings_service.dart';

@Injectable(as: BookingsService)
class BookingsServiceImpl implements BookingsService {
  final BookingsRemoteDatasource _bookingsRemoteDatasource;
  final BookingMapper _mapper;

  BookingsServiceImpl(this._bookingsRemoteDatasource, this._mapper);

  @override
  Future<List<Booking>> getUpcomingBookings() async {
    final bookingsResponse =
        await _bookingsRemoteDatasource.getUpcomingBookings();
    return _mapper.toBookingList(bookingsResponse);
  }

  @override
  Future<List<Booking>> getPastBookings() async {
    final bookingsResponse = await _bookingsRemoteDatasource.getPastBookings();
    return _mapper.toBookingList(bookingsResponse);
  }

  @override
  Future<void> book(int yachtId, String day) async {
    await _bookingsRemoteDatasource.book(yachtId, day);
  }

  @override
  Future<void> cancel(int bookingId) async {
    await _bookingsRemoteDatasource.cancel(bookingId);
  }
}

@injectable
class BookingMapper {
  List<Booking> toBookingList(List<BookingResponse> response) =>
      response.map((bookingResponse) => toBooking(bookingResponse)).toList();

  Booking toBooking(BookingResponse bookingResponse) => Booking(
    id: bookingResponse.id,
    yachtName: bookingResponse.yacht.name,
    day: bookingResponse.day,
    locationName: bookingResponse.location.name,
    locationImageUrl: bookingResponse.location.imageUrl,
  );
}
