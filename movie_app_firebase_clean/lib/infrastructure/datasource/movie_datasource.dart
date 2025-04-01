import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movie_app/data/interfaces/firebase_movie_datasource.dart';
import 'package:movie_app/domain/movie.dart';

class FirebaseMovieDataSourceImpl implements FirebaseMovieDataSource {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Future<void> addMovie(Movie movie) {
    // TODO: implement addMovie
    throw UnimplementedError();
  }

  @override
  Future<List<Movie>> getMovies() async {
    try {
      final docs = db.collection('movies').withConverter(
          fromFirestore: Movie.fromFirestore,
          toFirestore: (Movie movie, _) => movie.toFirestore());
      final movies = await docs.get();
      return movies.docs.map((d) => d.data()).toList();
    } catch (e) {
      print(e);
      return [];
    }
  }
}
