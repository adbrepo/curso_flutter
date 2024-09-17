import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../data/json_movies_repository.dart';
import '../../data/local_movies_repository.dart';
import '../../domain/models/movie_detailed.dart';
import '../../domain/repositories/movies_repository.dart';

class MovieDetailScreen extends StatefulWidget {
  const MovieDetailScreen({
    super.key,
    required this.movieId,
  });

  static const String name = 'movie_details_screen';
  final int movieId;

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late final Future<MovieDetailed> futureMovie;

  final MoviesRepository _repository = LocalMoviesRepository();
  //final MoviesRepository _repository = JsonMoviesRepository();

  @override
  void initState() {
    super.initState();

    futureMovie = _repository.getMovieById(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Details'),
      ),
      body: FutureBuilder<Object>(
        future: futureMovie,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final movie = snapshot.data as MovieDetailed;
          return _MovieDetailView(movie: movie);
        },
      ),
    );
  }
}

class _MovieDetailView extends StatelessWidget {
  const _MovieDetailView({
    super.key,
    required this.movie,
  });

  final MovieDetailed movie;

  @override
  Widget build(BuildContext context) {
    // TODO - Add a 'Favorite' button

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (movie.posterUrl != null)
              CachedNetworkImage(
                imageUrl: movie.posterUrl!,
                height: 400,
              ),
            const SizedBox(height: 16),
            Text(
              movie.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              'Release date: ${movie.releaseDate}',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontStyle: FontStyle.italic,
                  ),
            ),
            const SizedBox(height: 16),
            Text(
              movie.overview,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            Wrap(
              children: movie.genreList
                  .map((genre) => _GenreChip(genre: genre))
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}

class _GenreChip extends StatelessWidget {
  const _GenreChip({super.key, required this.genre});

  final String genre;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Chip(label: Text(genre)),
    );
  }
}
