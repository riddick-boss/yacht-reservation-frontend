import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yacht_reservation_frontend/domain/di/injection.dart';
import 'package:yacht_reservation_frontend/domain/models/yacht.dart';
import 'package:yacht_reservation_frontend/presentation/pages/home/cubit/home_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<HomeCubit>(),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: HomeHeader()),
              SliverToBoxAdapter(child: SizedBox(height: 16)),
              SliverToBoxAdapter(child: UpcomingReservationsSection()),
              SliverToBoxAdapter(child: SizedBox(height: 16)),
              SliverToBoxAdapter(
                child: BriefYachtListSection(yachts: state.yachts),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 16)),
              SliverToBoxAdapter(child: PromotionsBanner()),
              SliverToBoxAdapter(child: SizedBox(height: 16)),
              SliverToBoxAdapter(child: YachtsMapSection()),
              SliverToBoxAdapter(child: SizedBox(height: 16)),
              SliverToBoxAdapter(child: WeatherWidget()),
              SliverToBoxAdapter(child: SizedBox(height: 16)),
              SliverToBoxAdapter(child: QuickActionsWidget()),
              SliverToBoxAdapter(child: SizedBox(height: 32)),
            ],
          ),
        );
      },
    );
  }
}

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Mock user name
    final userName = 'Captain Jack';
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 48, 24, 0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: theme.primaryColor.withOpacity(0.1),
            child: Icon(Icons.person, size: 32, color: theme.primaryColor),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Good morning,', style: theme.textTheme.titleMedium),
                Text(
                  userName,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.notifications_none, color: theme.primaryColor, size: 28),
        ],
      ),
    );
  }
}

class UpcomingReservationsSection extends StatelessWidget {
  const UpcomingReservationsSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data
    final reservations = [
      {'yacht': 'Sea Breeze', 'date': '2024-07-10', 'location': 'Monaco'},
      {'yacht': 'Ocean Pearl', 'date': '2024-08-02', 'location': 'Ibiza'},
    ];
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Upcoming Reservations',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(onPressed: () {}, child: const Text('See all')),
            ],
          ),
          SizedBox(
            height: 100,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: reservations.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final res = reservations[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Container(
                    width: 180,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          res['yacht']!,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          res['location']!,
                          style: theme.textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              size: 16,
                              color: theme.primaryColor,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              res['date']!,
                              style: theme.textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class BriefYachtListSection extends StatelessWidget {
  final List<Yacht> yachts;
  const BriefYachtListSection({super.key, required this.yachts});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final briefYachts = yachts.take(3).toList();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Featured Yachts',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(onPressed: () {}, child: const Text('See all')),
            ],
          ),
          ...briefYachts.map(
            (yacht) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: YachtBriefCard(yacht: yacht),
            ),
          ),
          if (briefYachts.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                'No yachts available.',
                style: theme.textTheme.bodyMedium,
              ),
            ),
        ],
      ),
    );
  }
}

class YachtBriefCard extends StatelessWidget {
  final Yacht yacht;
  const YachtBriefCard({super.key, required this.yacht});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(
          Icons.directions_boat,
          color: theme.primaryColor,
          size: 36,
        ),
        title: Text(
          yacht.name,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(yacht.manufacturer),
        trailing: Text(
          '\$24${yacht.price}/day',
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.primaryColor,
          ),
        ),
        onTap: () {
          // TODO: Navigate to yacht details
        },
      ),
    );
  }
}

class PromotionsBanner extends StatelessWidget {
  const PromotionsBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Mock promotion
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        decoration: BoxDecoration(
          color: theme.primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Icon(Icons.local_offer, color: theme.primaryColor, size: 32),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Summer Sale!',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Book now and get 20% off on all yachts.',
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Book Now'),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class YachtsMapSection extends StatelessWidget {
  const YachtsMapSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Placeholder for map
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          color: theme.primaryColor.withOpacity(0.07),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.map,
                size: 48,
                color: theme.primaryColor.withOpacity(0.5),
              ),
              const SizedBox(height: 8),
              Text(
                'Yacht locations map coming soon!',
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WeatherWidget extends StatelessWidget {
  const WeatherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Mock weather
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        decoration: BoxDecoration(
          color: theme.primaryColor.withOpacity(0.08),
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Icon(Icons.wb_sunny, color: Colors.orange, size: 36),
            const SizedBox(width: 16),
            Text(
              '27°C, Sunny',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 12),
            Text('Monaco', style: theme.textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}

class QuickActionsWidget extends StatelessWidget {
  const QuickActionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _QuickActionButton(
            icon: Icons.add_circle_outline,
            label: 'Book Now',
            onTap: () {},
            color: theme.primaryColor,
          ),
          _QuickActionButton(
            icon: Icons.support_agent,
            label: 'Support',
            onTap: () {},
            color: Colors.green,
          ),
          _QuickActionButton(
            icon: Icons.info_outline,
            label: 'Yachting Tips',
            onTap: () {},
            color: Colors.blueAccent,
          ),
        ],
      ),
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color color;
  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.15),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
