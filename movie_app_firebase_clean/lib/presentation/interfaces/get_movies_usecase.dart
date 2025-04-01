import 'package:movie_app/domain/movie.dart';

abstract class GetMoviesUseCase {
  Future<List<Movie>> getMovies();
}
