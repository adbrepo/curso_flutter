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
  Movie? _movie;

  // Otros estados de la UI
  bool _isLoading = false;
  bool _hasError = false;

  void _getMovie() async {
    try {
      // Le indico al usuario que va a esperar un dato
      setState(() {
        _isLoading = true;
      });

      // Voy a buscar la movie al repositorio
      final futureMovie = MovieRepository().getMovieById(widget.movieId);

      // OJO Que el repo por si solo me retorna un future, tengo que esperarlo (await)
      final movie = await futureMovie;

      // Podrias hacer todo junto:
      //final movie = await MovieRepository().getMovieById(widget.movieId);

      // Ya con el dato, actualizo la UI
      setState(() {
        _isLoading = false;
        _movie = movie;
      });
    } catch (e) {
      // Si ocurre algun error, muestro eso
      setState(() {
        _isLoading = false;
        _hasError = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    // initState no puede ser async, asi que a la pelicula la llamo con una funcion, y esa es async
    _getMovie();
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    if (_isLoading) {
      body = const CircularProgressIndicator();
    } else if (_hasError) {
      body = const Text('Ocurrió un error');
    } else {
      // Aca ya estoy seguro que _movie tiene un valor, asi que puedo forzar no null (!)
      body = Column(
        children: [
          Text(
            _movie!.title,
            style: TextStyle(fontSize: 30),
          ),
          Text(_movie!.description),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Mi pelicula'),
      ),
      body: Center(
        child: body,
      ),
    );
  }
}
