import 'package:go_router/go_router.dart';

import '../../presentation/screens/movie_detail_screen.dart';
import '../../presentation/screens/movies_screen.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      name: MoviesScreen.name,
      path: '/',
      builder: (context, state) => MoviesScreen(),
    ),
    GoRoute(
      name: MovieDetailScreen.name,
      path: '/movie-details/:movieId',
      builder: (context, state) {
        // movieId as path parameter, like this: /movie-details/1
        final movieId = state.pathParameters['movieId'];
        return MovieDetailScreen(
          movieId: int.tryParse(movieId.toString()) ?? -1,
        );
      },
    ),
  ],
);
