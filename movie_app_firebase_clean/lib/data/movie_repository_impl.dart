import 'package:movie_app/data/interfaces/firebase_movie_datasource.dart';
import 'package:movie_app/domain/movie.dart';
import 'package:movie_app/usecases/interfaces/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final FirebaseMovieDataSource dataSource;

  MovieRepositoryImpl({required this.dataSource});

  @override
  Future<void> addMovie(Movie movie) {
    // TODO: implement addMovie
    throw UnimplementedError();
  }

  @override
  Future<List<Movie>> getMovies() {
    return dataSource.getMovies();
  }
}
