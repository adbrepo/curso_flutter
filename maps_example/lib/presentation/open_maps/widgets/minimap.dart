import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class OpenMinimap extends StatelessWidget {
  const OpenMinimap({
    super.key,
    required this.centerLocation,
    this.zoom = 13.0,
    this.marker,
    this.width,
    this.height,
  });

  final LatLng centerLocation;
  final double zoom;
  final Widget? marker;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: FlutterMap(
        options: MapOptions(
          initialCenter: centerLocation,
          initialZoom: zoom,
          interactionOptions: const InteractionOptions(
            flags: InteractiveFlag.none,
          ),
        ),
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
                point: centerLocation,
                child: marker ?? const SizedBox(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
