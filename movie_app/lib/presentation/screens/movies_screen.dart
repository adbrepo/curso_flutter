import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/core/data/movie_datasource.dart';
import 'package:movie_app/entities/movie.dart';
import 'package:movie_app/presentation/screens/movie_detail_screen.dart';
import 'package:movie_app/presentation/widgets/movie_item.dart';

class MoviesScreen extends StatelessWidget {
  static const String name = 'movies_screen';
  final List<Movie> movies = movieList;

  MoviesScreen({super.key});

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

class _MoviesView extends StatelessWidget {
  const _MoviesView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: movieList.length,
      itemBuilder: (context, index) {
        final movie = movieList[index];
        return MovieItem(
          movie: movie,
          onTap: () => _goToMovieDetails(context, movie),
        );
      },
    );
  }

  void _goToMovieDetails(BuildContext context, Movie movie) {
    context.pushNamed(
      MovieDetailScreen.name,
      pathParameters: {
        'movieId': movie.id,
      },
    );

    // Otra forma:
    //context.push('/movie-details/${movie.id}');
  }
}
