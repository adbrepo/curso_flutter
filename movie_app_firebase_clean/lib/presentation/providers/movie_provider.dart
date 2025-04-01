import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/domain/movie.dart';
import 'package:movie_app/presentation/interfaces/get_movies_usecase.dart';

class MoviesNotifier extends StateNotifier<List<Movie>> {
  final GetMoviesUseCase getMoviesUseCase;

  MoviesNotifier({required this.getMoviesUseCase}) : super([]);

  Future<void> addMovie(Movie movie) async {}

  Future<void> getAllMovies() async {
    final movies = await getMoviesUseCase.getMovies();
    state = [...state, ...movies];
  }
}
