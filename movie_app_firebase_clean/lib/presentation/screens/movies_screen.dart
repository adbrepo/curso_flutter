import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/domain/movie.dart';
import 'package:movie_app/presentation/providers/movie_provider.dart';

class MoviesScreen extends ConsumerStatefulWidget {
  static const String name = 'movies_screen';
  const MoviesScreen({super.key});

  @override
  ConsumerState<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends ConsumerState<MoviesScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(movieProvider.notifier).getAllMovies();
  }

  @override
  Widget build(BuildContext context) {
    List<Movie> movies = ref.watch(movieProvider);
    return Scaffold(
        appBar: AppBar(
          title: Text('Movies'),
        ),
        body: _MoviesView(
          movies: movies,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final newMovie = Movie(
              id: '1',
              title: 'The Shawshank Redemption',
              director: 'Frank Darabont',
              year: 2000,
            );
            await ref.read(movieProvider.notifier).addMovie(newMovie);
          },
          child: const Icon(Icons.add),
        ));
  }
}

class _MoviesView extends StatelessWidget {
  List<Movie> movies;
  _MoviesView({
    required this.movies,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return _MovieItemView(
            movie: movie,
          );
        });
  }
}

class _MovieItemView extends StatelessWidget {
  final Movie movie;

  const _MovieItemView({
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(movie.title),
        subtitle: Text(movie.director),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          context.push('/movie_detail/${movie.id}');
        },
      ),
    );
  }
}
