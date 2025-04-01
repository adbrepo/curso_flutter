import 'package:movie_app/domain/movie.dart';
import 'package:movie_app/presentation/interfaces/get_movies_usecase.dart';
import 'package:movie_app/usecases/interfaces/movie_repository.dart';

class GetMoviesUsecaseImpl implements GetMoviesUseCase {
  final MovieRepository _moviesRepository;

  GetMoviesUsecaseImpl(this._moviesRepository);

  @override
  Future<List<Movie>> getMovies() {
    return _moviesRepository.getMovies();
  }
}
