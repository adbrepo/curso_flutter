import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/domain/movie.dart';

final movieProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>(
  (ref) => MoviesNotifier(FirebaseFirestore.instance),
);

class MoviesNotifier extends StateNotifier<List<Movie>> {
  final FirebaseFirestore db;

  MoviesNotifier(this.db) : super([]);

  Future<void> addMovie(Movie movie) async {
    final doc = db.collection('movies').doc();
    try {
      await doc.set(movie.toFirestore());
      state = [...state, movie];
    } catch (e) {
      print(e);
    }
  }

  Future<void> getAllMovies() async {
    final docs = db.collection('movies').withConverter(
        fromFirestore: Movie.fromFirestore,
        toFirestore: (Movie movie, _) => movie.toFirestore());
    final movies = await docs.get();
    state = [...state, ...movies.docs.map((d) => d.data())];
  }
}
