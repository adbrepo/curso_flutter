import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/json_movies_repository.dart';
import '../../domain/models/movie.dart';
import '../widgets/movie_item.dart';
import 'movie_detail_screen.dart';

class MoviesScreen extends StatelessWidget {
  static const String name = 'movies_screen';

  const MoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies'),
      ),
      body: const _MoviesView(),
    );
  }
}

class _MoviesView extends StatefulWidget {
  const _MoviesView({super.key});

  @override
  State<_MoviesView> createState() => _MoviesViewState();
}

class _MoviesViewState extends State<_MoviesView> {
  late final Future<List<Movie>> moviesFuture;

  @override
  void initState() {
    super.initState();
    moviesFuture = JsonMoviesRepository().getMovies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: moviesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final movieList = snapshot.data as List<Movie>;
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.6,
            // It's 2/3 for movie posters, plus an extra for the release date
          ),
          itemCount: movieList.length,
          itemBuilder: (context, index) {
            final movie = movieList[index];
            return MovieItem(
              movie: movie,
              onTap: () => _goToMovieDetails(context, movie),
            );
          },
        );
      },
    );
  }

  void _goToMovieDetails(BuildContext context, Movie movie) {
    context.pushNamed(
      MovieDetailScreen.name,
      pathParameters: {
        'movieId': movie.id.toString(),
      },
    );
  }
}
