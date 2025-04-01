import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/infrastructure/datasource/movie_datasource.dart';
import 'package:movie_app/domain/movie.dart';

class MovieDetailScreen extends ConsumerWidget {
  static const String name = 'movie_detail_screen';

  final String movieId;
  Movie? movie;

  MovieDetailScreen({super.key, required this.movieId, this.movie});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Movie Detail'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {},
          ),
        ],
      ),
      body: _MovieDetailView(
        movieId: movieId,
      ),
    );
  }
}

class _MovieDetailView extends StatelessWidget {
  final String movieId;

  const _MovieDetailView({
    super.key,
    required this.movieId,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    final TextEditingController titleController = TextEditingController();
    final TextEditingController directorController = TextEditingController();
    final TextEditingController yearController = TextEditingController();

    final Movie movie = movies.firstWhere((movie) => movie.id == movieId);

    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                movie.posterUrl ?? '',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: titleController..text = movie.title,
              decoration: const InputDecoration(
                hintText: 'Title',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: directorController..text = movie.director,
              decoration: const InputDecoration(
                hintText: 'Director',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: yearController..text = movie.year.toString(),
              decoration: const InputDecoration(
                hintText: 'Year',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
