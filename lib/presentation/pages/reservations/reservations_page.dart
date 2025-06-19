import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yacht_reservation_frontend/domain/models/reservation.dart';
import 'package:yacht_reservation_frontend/presentation/pages/reservations/cubit/reservations_cubit.dart';
import 'package:yacht_reservation_frontend/domain/di/injection.dart';

class ReservationsPage extends StatelessWidget {
  const ReservationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ReservationsCubit>(),
      child: const _ReservationsView(),
    );
  }
}

class _ReservationsView extends StatelessWidget {
  const _ReservationsView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Reservations'),
          centerTitle: true,
          elevation: 0,
          backgroundColor: theme.scaffoldBackgroundColor,
          foregroundColor: theme.primaryColor,
          bottom: TabBar(
            indicatorColor: theme.primaryColor,
            labelColor: theme.primaryColor,
            unselectedLabelColor: theme.textTheme.bodyMedium?.color,
            tabs: const [Tab(text: 'Upcoming'), Tab(text: 'Past')],
          ),
        ),
        body: BlocBuilder<ReservationsCubit, ReservationsState>(
          builder: (context, state) {
            return switch (state) {
              Loading() => const Center(child: CircularProgressIndicator()),
              Error(:final message) => Center(child: Text('Error: $message')),
              Loaded(:final upcoming, :final past) => TabBarView(
                children: [
                  _ReservationsList(
                    reservations: upcoming,
                    emptyText: 'No upcoming reservations.',
                    showCancel: true,
                  ),
                  _ReservationsList(
                    reservations: past,
                    emptyText: 'No past reservations.',
                    faded: true,
                  ),
                ],
              ),
            };
          },
        ),
      ),
    );
  }
}

class _ReservationsList extends StatelessWidget {
  final List<Reservation> reservations;
  final String emptyText;
  final bool faded;
  final bool showCancel;
  const _ReservationsList({
    required this.reservations,
    required this.emptyText,
    this.faded = false,
    this.showCancel = false,
  });

  @override
  Widget build(BuildContext context) {
    if (reservations.isEmpty) {
      return Center(child: Text(emptyText));
    }
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      itemCount: reservations.length,
      separatorBuilder: (_, __) => const SizedBox(height: 14),
      itemBuilder:
          (context, i) => _ReservationCard(
            reservation: reservations[i],
            faded: faded,
            showCancel: showCancel,
          ),
    );
  }
}

class _ReservationCard extends StatelessWidget {
  final Reservation reservation;
  final bool faded;
  final bool showCancel;
  const _ReservationCard({
    required this.reservation,
    this.faded = false,
    this.showCancel = false,
  });

  void _onCancel(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Cancel Reservation'),
            content: const Text(
              'Are you sure you want to cancel this reservation?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Yes, Cancel'),
              ),
            ],
          ),
    );
    if (confirmed == true) {
      // TODO: Implement cancellation logic
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Reservation cancelled (mock).')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      child: Stack(
        children: [
          // Card shadow
          Container(
            height: 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.13),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
          ),
          // Card content
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Stack(
              children: [
                SizedBox(
                  height: 140,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Background image
                      Image.network(
                        reservation.image,
                        fit: BoxFit.cover,
                        color: faded ? Colors.grey.withOpacity(0.5) : null,
                        colorBlendMode: faded ? BlendMode.saturation : null,
                        errorBuilder:
                            (context, error, stackTrace) => Container(
                              color: theme.primaryColor.withOpacity(0.08),
                              child: Icon(
                                Icons.directions_boat,
                                color: theme.primaryColor,
                                size: 40,
                              ),
                            ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.black.withOpacity(0.18),
                              Colors.black.withOpacity(0.10),
                            ],
                          ),
                        ),
                      ),
                      // Accent bar
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          width: 8,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                theme.primaryColor,
                                theme.colorScheme.secondary,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(24),
                              bottomLeft: Radius.circular(24),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Card content
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 18, 18, 18),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                reservation.yacht,
                                style: theme.textTheme.titleLarge?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black.withOpacity(0.3),
                                      blurRadius: 4,
                                    ),
                                  ],
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Icon(
                                    Icons.place,
                                    size: 17,
                                    color: Colors.white70,
                                  ),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child: Text(
                                      reservation.location,
                                      style: theme.textTheme.bodyMedium
                                          ?.copyWith(
                                            color: Colors.white70,
                                            fontWeight: FontWeight.w400,
                                          ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 7,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.13),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.calendar_today,
                                      size: 15,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      reservation.date,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (showCancel) ...[
                          const SizedBox(width: 10),
                          // Floating cancel button
                          Material(
                            color: Colors.transparent,
                            elevation: 6,
                            shape: const CircleBorder(),
                            child: InkWell(
                              onTap: () => _onCancel(context),
                              customBorder: const CircleBorder(),
                              child: Ink(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.redAccent,
                                      Colors.red.shade700,
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(13),
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 22,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
