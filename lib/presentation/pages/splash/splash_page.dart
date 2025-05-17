import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:yacht_reservation_frontend/domain/di/injection.dart';
import 'package:yacht_reservation_frontend/presentation/navigation/app_router.dart';
import 'package:yacht_reservation_frontend/presentation/pages/splash/cubit/splash_cubit.dart';
import 'package:yacht_reservation_frontend/presentation/theme/app_colors.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SplashCubit>(),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state.status == Status.authenticated) {
            context.go(Routes.home);
          } else if (state.status == Status.unauthenticated) {
            context.go(Routes.login);
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.background,
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.directions_boat, size: 100, color: AppColors.primary),
                const SizedBox(height: 24),
                Text(
                  'Yacht Reservation',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 48),
                CircularProgressIndicator(color: AppColors.primary),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
