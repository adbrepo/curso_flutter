import 'package:cloud_firestore/cloud_firestore.dart';

class Movie {
  final String id;
  final String title;
  final String director;
  final int year;
  final String? posterUrl;

  Movie({
    required this.id,
    required this.title,
    required this.director,
    required this.year,
    this.posterUrl,
  });

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'title': title,
      'director': director,
      'year': year,
      'posterUrl': posterUrl,
    };
  }

  static Movie fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();

    return Movie(
      id: data?['id'],
      title: data?['title'],
      director: data?['director'],
      year: data?['year'],
    );
  }
}
