import 'package:go_router/go_router.dart';
import 'package:yacht_reservation_frontend/presentation/pages/home/home_page.dart';
import 'package:yacht_reservation_frontend/presentation/pages/login/login_page.dart';
import 'package:yacht_reservation_frontend/presentation/pages/main_nav_host/main_nav_host.dart';
import 'package:yacht_reservation_frontend/presentation/pages/reservations/reservations_page.dart';
import 'package:yacht_reservation_frontend/presentation/pages/splash/splash_page.dart';
import 'package:yacht_reservation_frontend/presentation/pages/yachts/yachts_page.dart';
import 'package:yacht_reservation_frontend/presentation/widget/placeholder_page.dart';

final router = GoRouter(
  initialLocation: Routes.splash,
  routes: [
    GoRoute(
      path: Routes.splash,
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(path: Routes.login, builder: (context, state) => const LoginPage()),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainNavHost(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.home,
              builder: (context, state) => const HomePage(),
            ),
            GoRoute(
              path: Routes.yachts,
              builder: (context, state) => const YachtsPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.reservations,
              builder: (context, state) => const ReservationsPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.profile,
              builder:
                  (context, state) => const PlaceholderPage(title: 'Profile'),
            ),
          ],
        ),
      ],
    ),
  ],
  debugLogDiagnostics: true,
);

class Routes {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String home = '/home';
  static const String reservations = '/reservations';
  static const String profile = '/profile';
  static const String yachts = '/yachts';
}
