// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yacht_reservation_frontend/domain/di/injection.dart';
import 'package:yacht_reservation_frontend/domain/models/yacht.dart';
import 'package:yacht_reservation_frontend/presentation/pages/yachts/cubit/yachts_cubit.dart';
import 'package:yacht_reservation_frontend/presentation/widget/booking_bottom_sheet.dart';

class YachtsPage extends StatelessWidget {
  const YachtsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<YachtsCubit>(),
      child: const _YachtsView(),
    );
  }
}

class _YachtsView extends StatelessWidget {
  const _YachtsView();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<YachtsCubit, YachtsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('All Yachts'),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            foregroundColor: Theme.of(context).primaryColor,
          ),
          body: switch (state) {
            Loading() => const _LoadingView(),
            Loaded(:final yachts) => _YachtsListView(yachts: yachts),
          },
        );
      },
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();
  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class _YachtsListView extends StatelessWidget {
  final List<Yacht> yachts;
  const _YachtsListView({required this.yachts});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: yachts.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: YachtListItem(
            yacht: yachts[index],
            onBookClick: (yacht, date) async {
              await context.read<YachtsCubit>().bookYacht(yacht.id, date);
            },
          ),
        );
      },
    );
  }
}

class YachtListItem extends StatelessWidget {
  final Yacht yacht;
  final Future<void> Function(Yacht, DateTime) onBookClick;
  const YachtListItem({
    super.key,
    required this.yacht,
    required this.onBookClick,
  });

  void _showReservationDialog(BuildContext context, Yacht yacht) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return BookingBottomSheet(yacht: yacht, onBookClick: onBookClick);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Mock image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Stack(
              children: [
                Image.network(
                  yacht.imageUrl,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (context, error, stackTrace) => Container(
                        height: 180,
                        color: theme.primaryColor.withOpacity(0.1),
                        child: const Center(
                          child: Icon(Icons.directions_boat, size: 60),
                        ),
                      ),
                ),
                // Availability overlay
                if (!yacht.isAvailable)
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'NOT AVAILABLE',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        yacht.name,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: theme.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '\$${yacht.price}/day',
                        style: TextStyle(
                          color: theme.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  yacht.manufacturer,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.people, size: 18, color: theme.primaryColor),
                    const SizedBox(width: 6),
                    Text(
                      '${yacht.crewNum} Crew',
                      style: theme.textTheme.bodyMedium,
                    ),
                    const SizedBox(width: 18),
                    Icon(Icons.straighten, size: 18, color: theme.primaryColor),
                    const SizedBox(width: 6),
                    Text('${yacht.length}m', style: theme.textTheme.bodyMedium),
                    const SizedBox(width: 18),
                    Icon(
                      yacht.isAvailable ? Icons.check_circle : Icons.schedule,
                      size: 18,
                      color: yacht.isAvailable ? Colors.green : Colors.orange,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      yacht.isAvailable ? 'Available' : 'Coming Soon',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: yacht.isAvailable ? Colors.green : Colors.orange,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed:
                            yacht.isAvailable
                                ? () {
                                  _showReservationDialog(context, yacht);
                                }
                                : null,
                        icon: Icon(
                          yacht.isAvailable
                              ? Icons.event_available
                              : Icons.block,
                        ),
                        label: Text(
                          yacht.isAvailable
                              ? 'Make Reservation'
                              : 'Not Available',
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              yacht.isAvailable
                                  ? theme.primaryColor
                                  : Colors.grey[400],
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
