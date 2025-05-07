import 'package:flutter/material.dart';
import 'package:yacht_reservation_frontend/domain/di/injection.dart';
import 'package:yacht_reservation_frontend/presentation/navigation/app_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: router);
  }
}
