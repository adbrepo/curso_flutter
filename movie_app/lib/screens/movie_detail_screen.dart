import 'package:flutter/material.dart';
import 'package:movie_app/entities/movie.dart';

class MovieDetailScreen extends StatelessWidget {
  static const String name = 'movie_detail_screen';
  final Movie movie;
  const MovieDetailScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Detail'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Title: ${movie.title}'),
            Text('Director: ${movie.director}'),
            Text('Year: ${movie.year}'),
          ],
        ),
      ),
    );
  }
}
