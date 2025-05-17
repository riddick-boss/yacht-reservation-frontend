import 'package:freezed_annotation/freezed_annotation.dart';
import 'city.dart';

part 'reservation_state.freezed.dart';

@freezed
class ReservationState with _$ReservationState {
  const factory ReservationState({
    @Default(<City>[]) List<City> cities,
    @Default(<String>[]) List<String> countries,
    @Default(false) bool isLoading,
    String? errorMessage,
    City? selectedCity,
  }) = _ReservationState;

  ReservationState copyWith({required bool isLoading, required String errorMessage, required List<City> cities}) {}
}
