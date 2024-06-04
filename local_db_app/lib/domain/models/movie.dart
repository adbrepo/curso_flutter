import 'package:floor/floor.dart';

@entity
class Movie {
  @primaryKey
  final int id;
  final String title;
  final String overview;
  final String releaseDate;
  @ignore
  final List<int> genreIds;
  final String? posterUrl;
  final String? backdropUrl;
  int likes;

  Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.releaseDate,
    this.genreIds = const [],
    this.posterUrl,
    this.backdropUrl,
    this.likes = 0,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      overview: json['overview'],
      releaseDate: json['release_date'],
      genreIds: List<int>.from(json['genre_ids']),
      posterUrl: json['poster_path'] != null
          ? 'https://image.tmdb.org/t/p/w500${json['poster_path']}'
          : null,
      backdropUrl: json['backdrop_path'] != null
          ? 'https://image.tmdb.org/t/p/w500${json['backdrop_path']}'
          : null,
    );
  }
}
