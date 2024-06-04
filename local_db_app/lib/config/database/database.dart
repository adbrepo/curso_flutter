import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../../data/entities/movie_to_genre.dart';
import '../../data/json_movies_repository.dart';
import '../../data/movies_dao.dart';
import '../../domain/models/genre.dart';
import '../../domain/models/movie.dart';
import '../../domain/models/movie_detailed.dart';

part 'database.g.dart';

@Database(
  version: 1,
  entities: [Movie, Genre, MovieToGenre],
  views: [MovieDetailed],
)
abstract class AppDatabase extends FloorDatabase {
  MoviesDao get moviesDao;

  static Future<AppDatabase> create(String name) {
    return $FloorAppDatabase.databaseBuilder(name).addCallback(
      Callback(
        onCreate: (database, version) async {
          // This method is only called when the database is first created.
          await _prepopulateDb(database);
        },
      ),
    ).build();
  }

  static Future<void> _prepopulateDb(sqflite.DatabaseExecutor database) async {
    // Pre-populate the database with movies from the JSON file.
    final repository = JsonMoviesRepository();
    final movies = await repository.getMovies();
    final genres = await repository.getGenres();

    for (final movie in movies) {
      // Insert the movie into the database.
      await InsertionAdapter(
        database,
        'Movie',
        (Movie item) => <String, Object?>{
          'id': item.id,
          'title': item.title,
          'overview': item.overview,
          'releaseDate': item.releaseDate,
          'posterUrl': item.posterUrl,
          'backdropUrl': item.backdropUrl,
          'likes': item.likes,
        },
      ).insert(movie, OnConflictStrategy.replace);

      // Insert the genres for the movie into the database.
      for (final genreId in movie.genreIds) {
        final genre = genres.firstWhere((g) => g.id == genreId);
        final movieToGenre = MovieToGenre(
          movieId: movie.id,
          genreId: genre.id,
        );

        await InsertionAdapter(
          database,
          'MovieToGenre',
          (MovieToGenre item) => <String, Object?>{
            'movieId': item.movieId,
            'genreId': item.genreId,
          },
        ).insert(movieToGenre, OnConflictStrategy.replace);
      }
    }

    // Insert the genres into the database.
    for (final genre in genres) {
      await InsertionAdapter(
        database,
        'Genre',
        (Genre item) => <String, Object?>{
          'id': item.id,
          'name': item.name,
        },
      ).insert(genre, OnConflictStrategy.replace);
    }
  }
}
