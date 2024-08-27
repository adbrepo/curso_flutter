import 'package:flutter/material.dart';
import 'package:maps_example/core/routes/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Maps examples',
      routerConfig: appRouter,
    );
  }
}
