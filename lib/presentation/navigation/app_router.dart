
import 'package:go_router/go_router.dart';
import 'package:yacht_reservation_frontend/presentation/pages/home/home_page.dart';
import 'package:yacht_reservation_frontend/presentation/pages/login/login_page.dart';
import 'package:yacht_reservation_frontend/presentation/pages/splash/splash_page.dart';

import 'package:yacht_reservation_frontend/reservation/reservation_page.dart';

class Routes {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String home = '/home';
  static const String reservation = '/reservation';
}

final router = GoRouter(
  initialLocation: Routes.splash,
  routes: [
    GoRoute(
      path: Routes.splash,
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: Routes.login,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: Routes.home,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: Routes.reservation,
      builder: (context, state) => const ReservationPage(),
    ),
  ],
  debugLogDiagnostics: true,
);
