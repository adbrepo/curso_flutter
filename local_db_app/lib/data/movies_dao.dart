import 'package:floor/floor.dart';

import '../domain/models/genre.dart';
import '../domain/models/movie.dart';
import '../domain/models/movie_detailed.dart';
import 'entities/movie_to_genre.dart';

@dao
abstract class MoviesDao {
  @Query('SELECT * FROM Movie')
  Future<List<Movie>> findAllMovies();

  @Query('SELECT * FROM Movie WHERE id = :id')
  Future<Movie?> findMovieById(int id);

  @Query(
    'SELECT m.*, GROUP_CONCAT(g.name) AS genres FROM Movie m LEFT JOIN MovieToGenre mtg ON m.id = mtg.movieId LEFT JOIN Genre g ON mtg.genreId = g.id WHERE m.id = :id',
  )
  Future<MovieDetailed?> getDetailedMovieById(int id);

  @insert
  Future<void> insertMovie(Movie movie);

  @Insert(onConflict: OnConflictStrategy.ignore)
  Future<void> insertMovieGenres(List<MovieToGenre> movieGenres);

  @delete
  Future<void> deleteMovie(Movie movie);

  @update
  Future<void> updateMovie(Movie movie);

  @Query('SELECT * FROM Genre')
  Future<List<Genre>> getGenres();
}
