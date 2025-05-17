import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'reservation_cubit.dart';
import 'reservation_state.dart';
import 'city.dart';

class ReservationPage extends StatelessWidget {
  const ReservationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ReservationCubit()..loadCities(),
      child: const ReservationView(),
    );
  }
}

class ReservationView extends StatefulWidget {
  const ReservationView({Key? key}) : super(key: key);

  @override
  State<ReservationView> createState() => _ReservationViewState();
}

class _ReservationViewState extends State<ReservationView> {
  City? _selectedCity;
  String? _selectedYacht;
  DateTime? _startDate;
  DateTime? _endDate;

  final List<String> yachts = [
    'Antila 24', 'Maxus 28', 'Phobos 29', 'Laguna 30', 'Twister 780'
  ];

  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 0)),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rezerwacja jachtu')),
      body: BlocBuilder<ReservationCubit, ReservationState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.errorMessage != null) {
            return Center(child: Text('Błąd: ${state.errorMessage}'));
          }

          final cities = state.cities;
          if (cities.isEmpty) {
            return const Center(child: Text('Brak dostępnych miast'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Text('Wybierz miasto', style: TextStyle(fontSize: 16)),
                const SizedBox(height: 8),
                DropdownButton<City>(
                  isExpanded: true,
                  value: _selectedCity,
                  hint: const Text('Miasto'),
                  items: cities
                      .map((city) => DropdownMenuItem(
                            value: city,
                            child: Text('${city.name}, ${city.country}'),
                          ))
                      .toList(),
                  onChanged: (city) {
                    setState(() => _selectedCity = city);
                    context.read<ReservationCubit>().selectCity(city!);
                  },
                ),
                const SizedBox(height: 16),
                const Text('Wybierz jacht', style: TextStyle(fontSize: 16)),
                const SizedBox(height: 8),
                DropdownButton<String>(
                  isExpanded: true,
                  value: _selectedYacht,
                  hint: const Text('Jacht'),
                  items: yachts
                      .map((yacht) => DropdownMenuItem(
                            value: yacht,
                            child: Text(yacht),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() => _selectedYacht = value);
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () => _selectDate(context, true),
                      child: Text(_startDate == null
                          ? 'Data od'
                          : 'Od: ${_startDate!.toLocal()}'.split(' ')[0]),
                    ),
                    ElevatedButton(
                      onPressed: () => _selectDate(context, false),
                      child: Text(_endDate == null
                          ? 'Data do'
                          : 'Do: ${_endDate!.toLocal()}'.split(' ')[0]),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  icon: const Icon(Icons.check),
                  label: const Text('Zarezerwuj'),
                  onPressed: () {
                    if (_selectedCity != null &&
                        _selectedYacht != null &&
                        _startDate != null &&
                        _endDate != null) {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text('Sukces!'),
                          content: Text(
                            'Zarezerwowano jacht $_selectedYacht\n'
                            'w: ${_selectedCity!.name}, ${_selectedCity!.country}\n'
                            'od: ${_startDate!.toLocal().toString().split(' ')[0]}\n'
                            'do: ${_endDate!.toLocal().toString().split(' ')[0]}',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Wypełnij wszystkie pola!'),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
