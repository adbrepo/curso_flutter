import 'package:movie_app/domain/movie.dart';

abstract class MovieRepository {
  Future<List<Movie>> getMovies();
  Future<void> addMovie(Movie movie);
}
