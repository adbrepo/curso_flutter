import 'package:starter_app_utn/domain/explain_interface.dart';

class Movie implements ExplainInterface {
  String title;
  String description;
  int rating;
  String? director;

  Movie({
    required this.title,
    required this.description,
    required this.rating,
    this.director = 'sin director',
  });

  @override
  String toString() {
    return 'Movie{title: $title, description: $description, rating: $rating, director: $director}';
  }

  @override
  String explain() {
    // TODO: implement explain
    return 'Movie{title: $title, description: $description, rating: $rating, director: $director}';
  }
}
