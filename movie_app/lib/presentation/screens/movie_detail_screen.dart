import 'package:flutter/material.dart';
import 'package:movie_app/core/data/movie_datasource.dart';
import 'package:movie_app/entities/movie.dart';

class MovieDetailScreen extends StatelessWidget {
  const MovieDetailScreen({
    super.key,
    required this.movieId,
  });

  static const String name = 'movie_details_screen';
  final String movieId;

  @override
  Widget build(BuildContext context) {
    final movie = movieList.firstWhere((movie) => movie.id == movieId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Details'),
      ),
      body: _MovieDetailView(movie: movie),
    );
  }
}

class _MovieDetailView extends StatelessWidget {
  const _MovieDetailView({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (movie.poster != null) Image.network(movie.poster!, height: 400),
          const SizedBox(height: 16),
          Text(
            movie.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            'Director: ${movie.director}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Text(
            'Year: ${movie.year}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
