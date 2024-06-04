import 'package:flutter/material.dart';
import 'package:movie_app/entities/movie.dart';

class MovieItem extends StatelessWidget {
  const MovieItem({
    super.key,
    required this.movie,
    this.onTap,
  });

  final Movie movie;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: movie.poster != null
            ? _getPoster(movie.poster!)
            : const Icon(Icons.movie),
        title: Text(movie.title),
        subtitle: Text('Director: ${movie.director}'),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () => onTap?.call(),
      ),
    );
  }

  Widget _getPoster(String posterUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(posterUrl),
    );
  }
}
