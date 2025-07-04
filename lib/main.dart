import 'package:flutter/material.dart';
import 'package:yacht_reservation_frontend/domain/di/injection.dart';
import 'package:yacht_reservation_frontend/presentation/navigation/app_router.dart';
import 'package:yacht_reservation_frontend/presentation/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: router, theme: AppTheme.lightTheme);
  }
}
