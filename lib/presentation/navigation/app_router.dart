import 'package:go_router/go_router.dart';
import 'package:yacht_reservation_frontend/presentation/pages/splash/splash_page.dart';

final router = GoRouter(
  initialLocation: Routes.splash,
  routes: [
    GoRoute(
      path: Routes.splash,
      builder: (context, state) => const SplashPage(),
    ),
  ],
  debugLogDiagnostics: true,
);

class Routes {
  static const String splash = '/splash';
  // static const String login = '/login';
  // static const String register = '/register';
  // static const String home = '/home';
}
