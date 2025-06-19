import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yacht_reservation_frontend/domain/models/yacht.dart';
import 'package:yacht_reservation_frontend/domain/services/bookings_service.dart';
import 'package:yacht_reservation_frontend/domain/services/yachts_service.dart';
import 'package:injectable/injectable.dart';
import 'package:yacht_reservation_frontend/domain/util/app_logger.dart';

part 'yachts_state.dart';
part 'yachts_cubit.freezed.dart';

@injectable
class YachtsCubit extends Cubit<YachtsState> {
  final YachtsService _yachtsService;
  final BookingsService _bookingsService;

  YachtsCubit(this._yachtsService, this._bookingsService)
    : super(const YachtsState.loading()) {
    _getYachts();
  }

  Future<void> _getYachts() async {
    emit(const YachtsState.loading());
    try {
      final yachts = await _yachtsService.getYachts();
      emit(YachtsState.loaded(yachts));
    } catch (e) {
      AppLogger.err(e);
    }
  }

  Future<void> bookYacht(int yachtId, DateTime day) async {
    try {
      final dayString =
          '${day.year}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}';
      await _bookingsService.book(yachtId, dayString);
    } catch (e) {
      AppLogger.err(e);
    }
  }
}
