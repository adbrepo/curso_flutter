import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_example/entities/movie.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final movieList = movies;


    return  Scaffold(

      body: ListView.builder(
        itemCount: movieList.length,
        itemBuilder: (context, index){
          return   Card(
            child: ListTile(
              title: Text(movieList[index].title),
              subtitle: Text('${movieList[index].director} - ${movieList[index].year}'),
              leading: Image.network(
                movieList[index].posterUrl,
                width: 50,
                height: 75,
                fit: BoxFit.cover,
              ),
              onTap: (){
                context.push('/movie-detail', extra: movieList[index]);


              },
            
            ),
          );
        },



      

    ));
  }
}