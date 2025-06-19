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
  const _ReservationsList({
    required this.reservations,
    required this.emptyText,
    this.faded = false,
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
          (context, i) =>
              _ReservationCard(reservation: reservations[i], faded: faded),
    );
  }
}

class _ReservationCard extends StatelessWidget {
  final Reservation reservation;
  final bool faded;
  const _ReservationCard({required this.reservation, this.faded = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Stack(
        children: [
          // Background image
          SizedBox(
            height: 120,
            child: Stack(
              fit: StackFit.expand,
              children: [
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
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.18),
                        Colors.black.withOpacity(0.45),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 0, 14, 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          reservation.yacht,
                          style: theme.textTheme.titleMedium?.copyWith(
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
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Icon(Icons.place, size: 15, color: Colors.white70),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                reservation.location,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w400,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
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
          ),
        ],
      ),
    );
  }
}
