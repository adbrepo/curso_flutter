import 'package:go_router/go_router.dart';
import 'package:movie_app/entities/movie.dart';
import 'package:movie_app/screens/movie_detail_screen.dart';
import 'package:movie_app/screens/movies_screen.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
        name: MoviesScreen.name,
        path: '/',
        builder: (context, state) => MoviesScreen()),
    GoRoute(
        name: MovieDetailScreen.name,
        path: '/movies-detail',
        builder: (context, state) => MovieDetailScreen(
              movie: state.extra as Movie,
            )),
  ],
);
