import 'package:counter_state/presentation/screens/home_screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(path: '/home',builder: (context,state) => const HomeScreen()),
  ]
);