import 'package:floor/floor.dart';

@DatabaseView(
  'SELECT m.*, GROUP_CONCAT(g.name) AS genres FROM Movie m LEFT JOIN MovieToGenre mtg ON m.id = mtg.movieId LEFT JOIN Genre g ON mtg.genreId = g.id',
)
class MovieDetailed {
  final int id;
  final String title;
  final String overview;
  final String releaseDate;
  final String genres;
  final String? posterUrl;
  final String? backdropUrl;
  int likes;

  MovieDetailed({
    required this.id,
    required this.title,
    required this.overview,
    required this.releaseDate,
    required this.genres,
    this.posterUrl,
    this.backdropUrl,
    this.likes = 0,
  });

  List<String> get genreList => genres.split(',');
}
