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
      listener: (context, state) {
        // Handle state changes here
      },
      builder: (context, state) {
        return Scaffold(body: YachtList(yachts: state.yachts));
      },
    );
  }
}

class YachtList extends StatelessWidget {
  final List<Yacht> yachts;

  const YachtList({super.key, yac, required this.yachts});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [for (final yacht in yachts) YachtBox(yacht: yacht)],
    );
  }
}

class YachtBox extends StatelessWidget {
  final Yacht yacht;

  const YachtBox({super.key, required this.yacht});

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      child: Column(
        children: [
          Text(yacht.name),
          Text(yacht.manufacturer),
          Text('Crew: ${yacht.crewNum}'),
          Text('Length: ${yacht.length}'),
          Text('Price: ${yacht.price}'),
        ],
      ),
    );
  }
}
