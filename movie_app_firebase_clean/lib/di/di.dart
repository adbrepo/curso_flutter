import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/data/movie_repository_impl.dart';
import 'package:movie_app/infrastructure/datasource/movie_datasource.dart';
import 'package:movie_app/usecases/get_movies_usecase_impl.dart';
import 'package:movie_app/usecases/interfaces/movie_repository.dart';

final movieDataSourceProvider = Provider<FirebaseMovieDataSourceImpl>((ref) {
  return FirebaseMovieDataSourceImpl();
});
final movieRepositoryProvider = Provider((ref) =>
    MovieRepositoryImpl(dataSource: ref.read(movieDataSourceProvider)));

final getMoviesUseCaseProvider =
    Provider((ref) => GetMoviesUsecaseImpl(ref.read(movieRepositoryProvider)));
