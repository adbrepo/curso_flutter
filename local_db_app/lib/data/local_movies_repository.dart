import '../main.dart';
import '../domain/models/genre.dart';
import '../domain/models/movie.dart';
import '../domain/models/movie_detailed.dart';
import 'entities/movie_to_genre.dart';
import 'movies_dao.dart';
import '../domain/repositories/movies_repository.dart';

class LocalMoviesRepository implements MoviesRepository {
  // TODO - inject this DAO
  final MoviesDao _moviesDao = database.moviesDao;

  @override
  Future<List<Genre>> getGenres() {
    return _moviesDao.getGenres();
  }

  @override
  Future<MovieDetailed> getMovieById(int id) {
    return _moviesDao.getDetailedMovieById(id).then((movie) => movie!);
  }

  @override
  Future<List<Movie>> getMovies() {
    return _moviesDao.findAllMovies();
  }

  @override
  Future<void> insertMovie(Movie movie) async {
    await _moviesDao.insertMovie(movie);
    final movieGenres = movie.genreIds
        .map((genreId) => MovieToGenre(movieId: movie.id, genreId: genreId))
        .toList();
    await _moviesDao.insertMovieGenres(movieGenres);
  }

  @override
  Future<void> updateMovie(Movie movie) async {
    return _moviesDao.updateMovie(movie);
  }
}
