import 'package:movie_app/domain/movie.dart';

abstract class FirebaseMovieDataSource {
  Future<List<Movie>> getMovies();
  Future<void> addMovie(Movie movie);
}
