import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_example/core/utils/caba_points.dart';

class GeocodingScreen extends StatefulWidget {
  const GeocodingScreen({super.key});

  @override
  State<GeocodingScreen> createState() => _GeocodingFullScreenState();
}

class _GeocodingFullScreenState extends State<GeocodingScreen> {
  final _geocodingController = TextEditingController();

  late final GoogleMapController _mapController;

  final CameraPosition _initialPosition = CameraPosition(
    target: LatLng(obeliscoLatLng.latitude, obeliscoLatLng.longitude),
    zoom: 17,
  );

  final Set<Marker> _markers = {};

  @override
  void dispose() {
    super.dispose();

    _mapController.dispose();
    _geocodingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Geocoding example'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _geocodingController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Buscar dirección',
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) => _searchAddress(value),
            ),
          ),
          Expanded(
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _initialPosition,
              onMapCreated: (GoogleMapController controller) {
                _mapController = controller;
              },
              markers: _markers,
            ),
          ),
        ],
      ),
    );
  }

  void _searchAddress(String address) async {
    debugPrint('Buscar dirección: $address');
    List<Location> locations = await locationFromAddress(address);
    if (locations.isNotEmpty) {
      final location = locations.first;
      debugPrint('Location: $location');
      await _mapController.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(location.latitude, location.longitude),
        ),
      );
      setState(() {
        _markers.add(
          Marker(
            markerId: MarkerId(address),
            position: LatLng(location.latitude, location.longitude),
            infoWindow: InfoWindow(
              title: 'Searched',
              snippet: address,
            ),
          ),
        );
      });
    }
  }
}
