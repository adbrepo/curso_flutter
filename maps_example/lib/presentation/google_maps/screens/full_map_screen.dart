import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_example/core/utils/caba_points.dart';

class GoogleMapsFullScreen extends StatefulWidget {
  const GoogleMapsFullScreen({super.key});

  @override
  State<GoogleMapsFullScreen> createState() => _GoogleMapsFullScreenState();
}

class _GoogleMapsFullScreenState extends State<GoogleMapsFullScreen> {
  late final GoogleMapController _mapController;

  final CameraPosition _initialPosition = CameraPosition(
    target: LatLng(obeliscoLatLng.latitude, obeliscoLatLng.longitude),
    zoom: 19,
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
        title: const Text('GoogleMaps fullscreen'),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _initialPosition,
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller;
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
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
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  void _moveToInitialLocation() async {
    await _mapController.animateCamera(
      CameraUpdate.newLatLngZoom(_initialPosition.target, 17),
    );
  }

  void _incrementZoom(int zoomChange) async {
    final newZoom = await _mapController.getZoomLevel() + zoomChange;
    await _mapController.animateCamera(
      CameraUpdate.zoomTo(newZoom),
    );
  }
}
