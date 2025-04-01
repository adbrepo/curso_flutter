import 'package:go_router/go_router.dart';
import 'package:movie_app/presentation/screens/movie_detail_screen.dart';
import 'package:movie_app/presentation/screens/movies_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/movies',
  routes: [
    GoRoute(
      path: '/movies',
      name: MoviesScreen.name,
      builder: (context, state) => const MoviesScreen(),
    ),
    GoRoute(
      path: '/movie_detail/:movieId',
      name: MovieDetailScreen.name,
      builder: (context, state) => MovieDetailScreen(
        movieId: state.pathParameters['movieId']!,
      ),
    )
  ],
);
