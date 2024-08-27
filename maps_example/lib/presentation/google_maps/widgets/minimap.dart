import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMinimap extends StatelessWidget {
  const GoogleMinimap({
    super.key,
    required this.centerLocation,
    this.zoom = 16.0,
    this.width,
    this.height,
  });

  final LatLng centerLocation;
  final double zoom;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: true,
      child: SizedBox(
        width: width,
        height: height,
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target: centerLocation,
            zoom: zoom,
          ),
          zoomControlsEnabled: false,
          markers: {
            Marker(
              markerId: MarkerId(centerLocation.toString()),
              position: centerLocation,
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueRed,
              ),
            ),
          },
        ),
      ),
    );
  }
}
