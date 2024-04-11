import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgets_app/config/router/app_router.dart';
import 'package:widgets_app/config/theme/app_theme.dart';
import 'package:widgets_app/config/theme/presentation/providers/theme_provider.dart';

void main() {
  runApp(const ProviderScope(
    child: MainApp(),
  ));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final isDarkMode = ref.watch(isDarkModeProvider);
    //final selectedColor = ref.watch(selectedColorProvider);

    final appTheme = ref.watch(themeNotifierProvider);

    return MaterialApp.router(
      title: 'Widgets App',
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: appTheme.getTheme(),
      // home: const HomeScreen(),
    );
  }
}
