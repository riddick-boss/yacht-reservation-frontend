import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yacht_reservation_frontend/domain/models/yacht.dart';
import 'package:yacht_reservation_frontend/domain/services/yachts_service.dart';
import 'package:injectable/injectable.dart';

part 'yachts_state.dart';
part 'yachts_cubit.freezed.dart';

@injectable
class YachtsCubit extends Cubit<YachtsState> {
  final YachtsService _yachtsService;

  YachtsCubit(this._yachtsService) : super(const YachtsState.loading()) {
    _getYachts();
  }

  Future<void> _getYachts() async {
    emit(const YachtsState.loading());
    try {
      final yachts = await _yachtsService.getYachts();
      emit(YachtsState.loaded(yachts));
    } catch (e) {
      emit(YachtsState.error(e.toString()));
    }
  }
}
