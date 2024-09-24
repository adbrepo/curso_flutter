// Copyright 2019 the Dart project authors. All rights reserved.
// Use of this source code is governed by a BSD-style license
// that can be found in the LICENSE file.

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
      ),
      home: const MyMoviePage(movieId: '1'),
    );
  }
}

// -------------------------------------------------------------------------------------

class Movie {
  String id;
  String title;
  String description;

  Movie(this.id, this.title, this.description);
}

class MovieRepository {
  Future<Movie> getMovieById(String id) async {
    // Aca irias a buscar a Firebase, lo simulo con un delay
    await Future.delayed(const Duration(seconds: 2));

    // Descomentar para probar el codigo de error
    //throw 'Error de db';

    return Movie('1', 'Star Wars', 'Peliculon');
  }
}

// -------------------------------------------------------------------------------------

class MyMoviePage extends StatefulWidget {
  final String movieId;

  const MyMoviePage({
    super.key,
    required this.movieId,
  });

  @override
  State<MyMoviePage> createState() => _MyMoviePageState();
}

class _MyMoviePageState extends State<MyMoviePage> {
  // Arranca en null, pero ya le vamos a dar su valor
  Future<Movie>? _futureMovie;

  @override
  void initState() {
    super.initState();

    // Inicializo mi future, que el FutureBuilder va a escuchar
    _futureMovie = MovieRepository().getMovieById(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi pelicula'),
      ),
      body: Center(
        child: FutureBuilder<Movie>(
          future: _futureMovie,
          builder: (BuildContext context, AsyncSnapshot<Movie> snapshot) {
            // Todo el await y el error handling lo maneja internamente el FutureBuilder
            // y nos devuelve el estado listo para procesar...
            
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return const Text('Ocurrió un error');
            } else {
              // Si no esta cargando y no tuvo error, significa que tengo dato
              final movie = snapshot.data!;
              return Column(
                children: [
                  Text(
                    movie.title,
                    style: TextStyle(fontSize: 30),
                  ),
                  Text(movie.description),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
