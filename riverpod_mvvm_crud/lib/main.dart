import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp.router(
        title: 'My notes',
        theme: ThemeData(
          colorSchemeSeed: Colors.yellow,
        ),
        routerConfig: appRouter,
      ),
    );
  }
}
