import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maps_example/core/utils/caba_points.dart';

class OpenMapFullScreen extends StatefulWidget {
  const OpenMapFullScreen({super.key});

  @override
  State<OpenMapFullScreen> createState() => _OpenMapFullScreenState();
}

class _OpenMapFullScreenState extends State<OpenMapFullScreen> {
  final _initialLocation = obeliscoLatLng;

  final _mapController = MapController();

  bool _showCenterButton = false;

  late final _mapOptions = MapOptions(
    initialCenter: _initialLocation,
    initialZoom: 17,
    interactionOptions: const InteractionOptions(
      flags: InteractiveFlag.all,
    ),
    onPositionChanged: (position, hasGesture) {
      if (hasGesture && !_showCenterButton) {
        setState(() => _showCenterButton = true);
      }
    },
  );

  @override
  void dispose() {
    super.dispose();

    _mapController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OpenMaps fullscreen'),
      ),
      body: FlutterMap(
        mapController: _mapController,
        options: _mapOptions,
        children: [
          // TileLayer configurado para levantar tiles de OpenStreetMap
          // Podria ser de otro proveedor como MapBox, Stamen, etc.
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          ),
          MarkerLayer(
            markers: [
              Marker(
                alignment: Alignment.topCenter,
                point: _initialLocation,
                child: const FaIcon(
                  FontAwesomeIcons.locationDot,
                  size: 40,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (_showCenterButton)
            FloatingActionButton(
              heroTag: 1,
              onPressed: _moveToInitialLocation,
              child: const Icon(Icons.location_searching),
            ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: 2,
            onPressed: () => _incrementZoom(1),
            child: const Icon(Icons.zoom_in),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: 3,
            onPressed: () => _incrementZoom(-1),
            child: const Icon(Icons.zoom_out),
          ),
        ],
      ),
    );
  }

  void _moveToInitialLocation() {
    _mapController.move(_initialLocation, 17);
    setState(() => _showCenterButton = false);
  }

  void _incrementZoom(int increment) {
    final newZoom = _mapController.camera.zoom + increment;
    _mapController.move(_mapController.camera.center, newZoom);
  }
}
