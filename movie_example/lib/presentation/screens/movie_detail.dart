import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie_example/entities/movie.dart';

class MovieDetail extends StatelessWidget {

  Movie movie ;

   MovieDetail({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Text(
          movie.title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}