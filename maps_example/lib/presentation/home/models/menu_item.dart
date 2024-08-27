import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maps_example/presentation/advanced/routes.dart';
import 'package:maps_example/presentation/google_maps/routes.dart';
import 'package:maps_example/presentation/open_maps/routes.dart';

class MenuItem {
  final String title;
  final String subtitle;
  final String route;
  final IconData icon;

  MenuItem({
    required this.title,
    required this.subtitle,
    required this.route,
    required this.icon,
  });
}

final googleMapsItems = [
  MenuItem(
    title: 'Fullscreen',
    subtitle: 'Mapa a pantalla completa con controles',
    route: GoogleMapsRoutes.fullscreenMap,
    icon: FontAwesomeIcons.mapLocation,
  ),
  MenuItem(
    title: 'Minimap',
    subtitle: 'Mini mapa como parte de una pantalla de información',
    route: GoogleMapsRoutes.minimap,
    icon: Icons.map,
  ),
];

final openMapsItems = [
  MenuItem(
    title: 'Fullscreen',
    subtitle: 'Mapa a pantalla completa con controles y marcadores',
    route: OpenMapsRoutes.fullscreenMap,
    icon: FontAwesomeIcons.mapLocation,
  ),
  MenuItem(
    title: 'Minimap',
    subtitle: 'Mini mapa como parte de una pantalla de información',
    route: OpenMapsRoutes.minimap,
    icon: Icons.map,
  ),
];

final mapUxItems = [
  MenuItem(
    title: 'Sliding up panel',
    subtitle: 'Basado en https://pub.dev/packages/sliding_up_panel',
    route: AdvancedExamplesRoutes.slidingUpMap,
    icon: FontAwesomeIcons.mapLocation,
  ),
  MenuItem(
    title: 'Geocoder',
    subtitle: 'Obtener las coordenadas de una dirección y viceversa',
    route: AdvancedExamplesRoutes.geocoder,
    icon: FontAwesomeIcons.mapPin,
  )
];
