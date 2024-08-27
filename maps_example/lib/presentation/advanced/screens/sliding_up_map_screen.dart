import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:maps_example/core/utils/caba_points.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

const String _cabaDescription = """
La Ciudad de Buenos Aires, capital de Argentina, es una metrópolis vibrante y cosmopolita, conocida por su rica historia, arquitectura europea y vida cultural intensa. 

Fundada en 1536 y refundada en 1580, Buenos Aires es el principal centro político, económico y cultural del país. 
La ciudad combina barrios tradicionales como San Telmo y La Boca, con sus calles adoquinadas y coloridos edificios, con áreas modernas como Puerto Madero. Reconocida por su apasionada afición al tango, la diversidad de su gastronomía y su animada vida nocturna, Buenos Aires es un destino imperdible en Sudamérica.
""";

class SlidingUpMapExample extends StatefulWidget {
  const SlidingUpMapExample({super.key});

  @override
  State<SlidingUpMapExample> createState() => _SlidingUpMapExampleState();
}

class _SlidingUpMapExampleState extends State<SlidingUpMapExample> {
  final _centroGeograficoCaba = const LatLng(
    -34.6139684726322,
    -58.444374863369966,
  );

  final _mapController = MapController();

  late final _mapOptions = MapOptions(
    initialCenter: _centroGeograficoCaba,
    initialZoom: 11.5,
    interactionOptions: const InteractionOptions(
      flags: InteractiveFlag.all,
    ),
  );

  final _panelController = PanelController();

  @override
  void dispose() {
    super.dispose();

    _mapController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    BorderRadiusGeometry radius = const BorderRadius.only(
      topLeft: Radius.circular(24.0),
      topRight: Radius.circular(24.0),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text("SlidingUpPanel Example"),
      ),
      body: SlidingUpPanel(
        controller: _panelController,
        borderRadius: radius,
        panel: _Panel(
          mapController: _mapController,
          panelController: _panelController,
        ),
        collapsed: Container(
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: radius,
          ),
          child: const Center(
            child: Text(
              "Conociendo la Ciudad",
              style: TextStyle(fontSize: 20.0, color: Colors.white),
            ),
          ),
        ),
        body: Padding(
          // Padding del alto del collapsed widget
          padding: const EdgeInsets.only(bottom: 100),
          child: FlutterMap(
            mapController: _mapController,
            options: _mapOptions,
            children: [
              // TileLayer configurado para levantar tiles de OpenStreetMap
              // Podria ser de otro proveedor como MapBox, Stamen, etc.
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              ),
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: cabaOutlinedPoints,
                    strokeWidth: 2.0,
                    color: Colors.blue,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Panel extends StatelessWidget {
  const _Panel({
    super.key,
    required this.mapController,
    required this.panelController,
  });

  final MapController mapController;
  final PanelController panelController;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(height: 36),
            const Text('Conociendo la Ciudad', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            const Text(
              _cabaDescription,
              textAlign: TextAlign.justify,
            ),
            const Text('Puntos de Interés', style: TextStyle(fontSize: 16)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: () async {
                    await panelController.close();
                    mapController.move(obeliscoLatLng, 16);
                  },
                  child: const Text('Obelisco'),
                ),
                OutlinedButton(
                  onPressed: () async {
                    await panelController.close();
                    mapController.move(teatroColonLatLng, 16);
                  },
                  child: const Text('Teatro Colón'),
                ),
                OutlinedButton(
                  onPressed: () async {
                    await panelController.close();
                    mapController.move(utnMedranoLatLng, 16);
                  },
                  child: const Text('UTN.BA'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
