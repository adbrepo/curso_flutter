import 'package:class_example/entities/Movie.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    Movie testMovie = Movie(
        title: 'Cars',
        description: 'A movie about cars',
        imageUrl: 'https://www.google.com',
        year: '2006');

    List<Movie> movieList = [
      Movie(
          title: 'Cars',
          description: 'A movie about cars',
          imageUrl: 'https://www.google.com',
          year: '2006'),
      Movie(
          title: 'Cars 2',
          description: 'A movie about cars',
          imageUrl: 'https://www.google.com',
          year: '2011'),
      Movie(
          title: 'Cars 3',
          description: 'A movie about cars',
          imageUrl: 'https://www.google.com',
          year: '2017'),
      Movie(
          title: 'Cars 4',
          description: 'A movie about cars',
          imageUrl: 'https://www.google.com',
          year: '2022'),
    ];

    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              const Text('Hello World!'),
              ElevatedButton(
                  onPressed: () {
                    print(testMovie.mostrarInformacion());
                  },
                  child: const Text('Mostrar Informacion')),
            ],
          ),
        ),
      ),
    );
  }
}
