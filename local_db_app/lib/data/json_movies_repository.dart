import 'dart:convert';

import 'package:flutter/services.dart';

import '../domain/models/genre.dart';
import '../domain/models/movie.dart';
import '../domain/models/movie_detailed.dart';
import '../domain/repositories/movies_repository.dart';

class JsonMoviesRepository implements MoviesRepository {
  @override
  Future<List<Movie>> getMovies() {
    return Future.delayed(
      const Duration(seconds: 2),
      () async {
        final jsonString = await rootBundle.loadString('assets/movies.json');
        final jsonList = json.decode(jsonString) as List;
        final movies = jsonList.map((json) => Movie.fromJson(json)).toList();
        return movies;
      },
    );
  }

  @override
  Future<List<Genre>> getGenres() {
    return Future.delayed(
      const Duration(seconds: 2),
      () async {
        final jsonString = await rootBundle.loadString('assets/genres.json');
        final jsonList = (json.decode(jsonString))['genres'] as List;
        final genres = jsonList.map((json) => Genre.fromJson(json)).toList();
        return genres;
      },
    );
  }

  @override
  Future<MovieDetailed> getMovieById(int id) async {
    final genres = await getGenres();
    final movies = await getMovies();

    final movie = movies.firstWhere((m) => m.id == id);
    final movieDetailed = MovieDetailed(
      id: movie.id,
      title: movie.title,
      overview: movie.overview,
      releaseDate: movie.releaseDate,
      genres: genres
          .where((g) => movie.genreIds.contains(g.id))
          .map((e) => e.name)
          .join(','),
      posterUrl: movie.posterUrl,
      backdropUrl: movie.backdropUrl,
      likes: movie.likes,
    );

    return Future.delayed(
      const Duration(seconds: 2),
      () => movieDetailed,
    );
  }

  @override
  Future<void> insertMovie(Movie movie) {
    return Future.delayed(
      const Duration(seconds: 2),
      () => null,
    );
  }

  @override
  Future<void> updateMovie(Movie movie) {
    return Future.delayed(
      const Duration(seconds: 2),
      () => null,
    );
  }
}
