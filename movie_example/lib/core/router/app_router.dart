import 'package:go_router/go_router.dart';
import 'package:movie_example/entities/movie.dart';
import 'package:movie_example/presentation/screens/movie_detail.dart';
import 'package:movie_example/presentation/screens/movies_screen.dart';


final appRouter = GoRouter(
  
  initialLocation: '/movies',
  routes: [
    GoRoute(path: '/movies', builder: (context, state) {
      return const MoviesScreen(); // Replace with MoviesScreen
    }),
    GoRoute(path:'/movie-detail', builder:(context,state)=> MovieDetail(movie: state.extra as Movie),),

]);