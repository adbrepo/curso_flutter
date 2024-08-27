import 'package:go_router/go_router.dart';
import 'package:maps_example/presentation/advanced/routes.dart';
import 'package:maps_example/presentation/advanced/screens/geocoding_screen.dart';
import 'package:maps_example/presentation/advanced/screens/sliding_up_map_screen.dart';
import 'package:maps_example/presentation/google_maps/routes.dart';
import 'package:maps_example/presentation/google_maps/screens/full_map_screen.dart';
import 'package:maps_example/presentation/google_maps/screens/minimap_screen.dart';
import 'package:maps_example/presentation/home/screens/home_screen.dart';
import 'package:maps_example/presentation/open_maps/routes.dart';
import 'package:maps_example/presentation/open_maps/screens/full_map_screen.dart';
import 'package:maps_example/presentation/open_maps/screens/minimap_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: GoogleMapsRoutes.fullscreenMap,
      name: GoogleMapsRoutes.fullscreenMap,
      builder: (context, state) => const GoogleMapsFullScreen(),
    ),
    GoRoute(
      path: GoogleMapsRoutes.minimap,
      name: GoogleMapsRoutes.minimap,
      builder: (context, state) => const GoogleMapsMinimapScreen(),
    ),
    GoRoute(
      path: OpenMapsRoutes.fullscreenMap,
      name: OpenMapsRoutes.fullscreenMap,
      builder: (context, state) => const OpenMapFullScreen(),
    ),
    GoRoute(
      path: OpenMapsRoutes.minimap,
      name: OpenMapsRoutes.minimap,
      builder: (context, state) => const OpenMapMinimapScreen(),
    ),
    GoRoute(
      path: AdvancedExamplesRoutes.slidingUpMap,
      name: AdvancedExamplesRoutes.slidingUpMap,
      builder: (context, state) => const SlidingUpMapExample(),
    ),
    GoRoute(
      path: AdvancedExamplesRoutes.geocoder,
      name: AdvancedExamplesRoutes.geocoder,
      builder: (context, state) => const GeocodingScreen(),
    ),
  ],
);
