class Movie {
  final String id;
  final String title;
  final String director;
  final int year;
  final String? poster;

  Movie({
    required this.id,
    required this.title,
    required this.director,
    required this.year,
    this.poster,
  });
}
