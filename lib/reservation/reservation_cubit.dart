import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yacht_reservation_frontend/reservation/city.dart';
import 'package:yacht_reservation_frontend/reservation/reservation_state.dart';

class ReservationCubit extends Cubit<ReservationState> {
  ReservationCubit() : super(const ReservationState());

  Future<void> loadCities() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final cities = [
        City(name: 'Gdańsk', country: 'Poland'),
        City(name: 'Warsaw', country: 'Poland'),
        City(name: 'Barcelona', country: 'Spain'),
        City(name: 'Venice', country: 'Italy'),
        City(name: 'Miami', country: 'USA'),
      ];
      await Future.delayed(const Duration(seconds: 1));
      emit(state.copyWith(cities: cities, isLoading: false));
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, errorMessage: 'Failed to load cities'));
    }
  }

  void selectCity(City city) {
    emit(state.copyWith(selectedCity: city));
  }
}
