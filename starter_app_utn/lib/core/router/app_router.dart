import 'package:go_router/go_router.dart';
import 'package:starter_app_utn/presentation/screens/home_screen.dart';
import 'package:starter_app_utn/presentation/screens/login_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginScreen(),
    ),
    // GoRoute(
    //   path: '/home',
    //   builder: (context, state) => HomeScreen(
    //     name: state.extra.toString(),
    //   ),
    // ),
    GoRoute(
      path: '/home/:id',
      builder: (context, state) => HomeScreen(
        name: state.pathParameters['id'].toString(),
      ),
    ),
  ],
);
