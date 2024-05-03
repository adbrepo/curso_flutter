import 'package:floor/floor.dart';

@entity
class MovieToGenre {
  @PrimaryKey(autoGenerate: true)
  final int id;
  final int movieId;
  final int genreId;

  MovieToGenre({
    this.id = 0,
    required this.movieId,
    required this.genreId,
  });
}
