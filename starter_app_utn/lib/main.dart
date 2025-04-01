import 'package:flutter/material.dart';
import 'package:starter_app_utn/core/router/app_router.dart';
import 'package:starter_app_utn/presentation/screens/home_screen.dart';
import 'package:starter_app_utn/presentation/screens/login_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
    );
  }
}
