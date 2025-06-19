import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:yacht_reservation_frontend/domain/models/booking.dart';
import 'package:yacht_reservation_frontend/domain/models/yacht.dart';
import 'package:yacht_reservation_frontend/domain/services/bookings_service.dart';
import 'package:yacht_reservation_frontend/domain/services/yachts_service.dart';
import 'package:yacht_reservation_frontend/domain/util/app_logger.dart';

part 'home_state.dart';
part 'home_cubit.freezed.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final YachtsService _yachtsService;
  final BookingsService _bookingsService;

  HomeCubit(this._yachtsService, this._bookingsService)
    : super(const HomeState()) {
    getYachts();
    getUpcomingBookings();
  }

  Future<void> getYachts() async {
    emit(state.copyWith(isLoading: true));
    try {
      final yachts = await _yachtsService.getFeaturedYachts();
      emit(state.copyWith(isLoading: false, yachts: yachts));
    } catch (e) {
      AppLogger.d('error: $e');
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> getUpcomingBookings() async {
    emit(state.copyWith(isLoading: true));
    try {
      final bookings = await _bookingsService.getUpcomingBookings();
      emit(
        state.copyWith(
          isLoading: false,
          upcomingBookings: bookings.take(3).toList(),
        ),
      );
    } catch (e) {
      AppLogger.d('error: $e');
      emit(state.copyWith(isLoading: false));
    }
  }
}
