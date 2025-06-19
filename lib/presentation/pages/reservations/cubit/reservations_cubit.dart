import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:yacht_reservation_frontend/domain/models/reservation.dart';

part 'reservations_state.dart';
part 'reservations_cubit.freezed.dart';

@injectable
class ReservationsCubit extends Cubit<ReservationsState> {
  ReservationsCubit() : super(const ReservationsState.loading()) {
    loadReservations();
  }

  Future<void> loadReservations() async {
    emit(const ReservationsState.loading());
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      // Mock data
      final upcoming = [
        Reservation(
          id: 1,
          yacht: 'Sea Breeze',
          date: '2024-07-10',
          location: 'Monaco',
          image:
              'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=400&q=80',
        ),
        Reservation(
          id: 2,
          yacht: 'Ocean Pearl',
          date: '2024-08-02',
          location: 'Ibiza',
          image:
              'https://images.unsplash.com/photo-1464983953574-0892a716854b?auto=format&fit=crop&w=400&q=80',
        ),
      ];
      final past = [
        Reservation(
          id: 3,
          yacht: 'Blue Wave',
          date: '2024-05-15',
          location: 'Nice',
          image:
              'https://images.unsplash.com/photo-1502086223501-7ea6ecd79368?auto=format&fit=crop&w=400&q=80',
          isPast: true,
        ),
        Reservation(
          id: 4,
          yacht: 'Sunset Dream',
          date: '2024-04-20',
          location: 'Santorini',
          image:
              'https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=crop&w=400&q=80',
          isPast: true,
        ),
      ];
      emit(ReservationsState.loaded(upcoming: upcoming, past: past));
    } catch (e) {
      emit(ReservationsState.error(e.toString()));
    }
  }
}
