// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  MoviesDao? _moviesDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Movie` (`id` INTEGER NOT NULL, `title` TEXT NOT NULL, `overview` TEXT NOT NULL, `releaseDate` TEXT NOT NULL, `posterUrl` TEXT, `backdropUrl` TEXT, `likes` INTEGER NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Genre` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `name` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `MovieToGenre` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `movieId` INTEGER NOT NULL, `genreId` INTEGER NOT NULL)');

        await database.execute(
            'CREATE VIEW IF NOT EXISTS `MovieDetailed` AS SELECT m.*, GROUP_CONCAT(g.name) AS genres FROM Movie m LEFT JOIN MovieToGenre mtg ON m.id = mtg.movieId LEFT JOIN Genre g ON mtg.genreId = g.id');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  MoviesDao get moviesDao {
    return _moviesDaoInstance ??= _$MoviesDao(database, changeListener);
  }
}

class _$MoviesDao extends MoviesDao {
  _$MoviesDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _movieInsertionAdapter = InsertionAdapter(
            database,
            'Movie',
            (Movie item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'overview': item.overview,
                  'releaseDate': item.releaseDate,
                  'posterUrl': item.posterUrl,
                  'backdropUrl': item.backdropUrl,
                  'likes': item.likes
                }),
        _movieToGenreInsertionAdapter = InsertionAdapter(
            database,
            'MovieToGenre',
            (MovieToGenre item) => <String, Object?>{
                  'id': item.id,
                  'movieId': item.movieId,
                  'genreId': item.genreId
                }),
        _movieUpdateAdapter = UpdateAdapter(
            database,
            'Movie',
            ['id'],
            (Movie item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'overview': item.overview,
                  'releaseDate': item.releaseDate,
                  'posterUrl': item.posterUrl,
                  'backdropUrl': item.backdropUrl,
                  'likes': item.likes
                }),
        _movieDeletionAdapter = DeletionAdapter(
            database,
            'Movie',
            ['id'],
            (Movie item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'overview': item.overview,
                  'releaseDate': item.releaseDate,
                  'posterUrl': item.posterUrl,
                  'backdropUrl': item.backdropUrl,
                  'likes': item.likes
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Movie> _movieInsertionAdapter;

  final InsertionAdapter<MovieToGenre> _movieToGenreInsertionAdapter;

  final UpdateAdapter<Movie> _movieUpdateAdapter;

  final DeletionAdapter<Movie> _movieDeletionAdapter;

  @override
  Future<List<Movie>> findAllMovies() async {
    return _queryAdapter.queryList('SELECT * FROM Movie',
        mapper: (Map<String, Object?> row) => Movie(
            id: row['id'] as int,
            title: row['title'] as String,
            overview: row['overview'] as String,
            releaseDate: row['releaseDate'] as String,
            posterUrl: row['posterUrl'] as String?,
            backdropUrl: row['backdropUrl'] as String?,
            likes: row['likes'] as int));
  }

  @override
  Future<Movie?> findMovieById(int id) async {
    return _queryAdapter.query('SELECT * FROM Movie WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Movie(
            id: row['id'] as int,
            title: row['title'] as String,
            overview: row['overview'] as String,
            releaseDate: row['releaseDate'] as String,
            posterUrl: row['posterUrl'] as String?,
            backdropUrl: row['backdropUrl'] as String?,
            likes: row['likes'] as int),
        arguments: [id]);
  }

  @override
  Future<MovieDetailed?> getDetailedMovieById(int id) async {
    return _queryAdapter.query(
        'SELECT m.*, GROUP_CONCAT(g.name) AS genres FROM Movie m LEFT JOIN MovieToGenre mtg ON m.id = mtg.movieId LEFT JOIN Genre g ON mtg.genreId = g.id WHERE m.id = ?1',
        mapper: (Map<String, Object?> row) => MovieDetailed(id: row['id'] as int, title: row['title'] as String, overview: row['overview'] as String, releaseDate: row['releaseDate'] as String, genres: row['genres'] as String, posterUrl: row['posterUrl'] as String?, backdropUrl: row['backdropUrl'] as String?, likes: row['likes'] as int),
        arguments: [id]);
  }

  @override
  Future<List<Genre>> getGenres() async {
    return _queryAdapter.queryList('SELECT * FROM Genre',
        mapper: (Map<String, Object?> row) =>
            Genre(id: row['id'] as int, name: row['name'] as String));
  }

  @override
  Future<void> insertMovie(Movie movie) async {
    await _movieInsertionAdapter.insert(movie, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertMovieGenres(List<MovieToGenre> movieGenres) async {
    await _movieToGenreInsertionAdapter.insertList(
        movieGenres, OnConflictStrategy.ignore);
  }

  @override
  Future<void> updateMovie(Movie movie) async {
    await _movieUpdateAdapter.update(movie, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteMovie(Movie movie) async {
    await _movieDeletionAdapter.delete(movie);
  }
}
