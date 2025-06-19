import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:yacht_reservation_frontend/domain/models/booking.dart';
import 'package:yacht_reservation_frontend/domain/services/bookings_service.dart';

part 'reservations_state.dart';
part 'reservations_cubit.freezed.dart';

@injectable
class ReservationsCubit extends Cubit<ReservationsState> {
  final BookingsService _bookingsService;

  ReservationsCubit(this._bookingsService)
    : super(const ReservationsState.loading()) {
    loadReservations();
  }

  Future<void> loadReservations() async {
    emit(const ReservationsState.loading());
    try {
      final upcoming = await _bookingsService.getUpcomingBookings();
      upcoming.sort((a, b) => a.day.compareTo(b.day));

      final past = await _bookingsService.getPastBookings();
      past.sort((a, b) => b.day.compareTo(a.day));

      emit(ReservationsState.loaded(upcoming: upcoming, past: past));
    } catch (e) {
      emit(ReservationsState.error(e.toString()));
    }
  }
}
