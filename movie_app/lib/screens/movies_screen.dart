import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/core/data/movie_datasource.dart';
import 'package:movie_app/entities/movie.dart';
import 'package:movie_app/screens/movie_detail_screen.dart';

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
      body: const MoviesView(),
    );
  }
}

class MoviesView extends StatelessWidget {
  const MoviesView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: movieList.length,
        itemBuilder: (context, index) {
          final movie = movieList[index];
          return Card(
            child: ListTile(
              title: Text(movie.title),
              subtitle: Text('Director: ${movie.director}'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                context.pushNamed(MovieDetailScreen.name, extra: movie);
              },
            ),
          );
        });
  }
}
