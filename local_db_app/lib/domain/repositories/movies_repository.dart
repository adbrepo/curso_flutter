import '../models/genre.dart';
import '../models/movie.dart';
import '../models/movie_detailed.dart';

abstract class MoviesRepository {
  Future<List<Movie>> getMovies();
  Future<List<Genre>> getGenres();
  Future<MovieDetailed> getMovieById(int id);

  Future<void> insertMovie(Movie movie);
  Future<void> updateMovie(Movie movie);
}
