import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maps_example/core/utils/caba_points.dart';
import 'package:maps_example/presentation/open_maps/widgets/minimap.dart';

const _utnDescription = """
La Universidad Tecnológica Nacional - Facultad Regional Buenos Aires (UTN) es una de las instituciones más destacadas en la formación de ingenieros en Argentina. 

Fundada en 1952, esta facultad es parte de la UTN, una universidad pública con una fuerte orientación tecnológica e industrial. 

La UTN ofrece una amplia gama de carreras de grado y posgrado en ingeniería, además de programas de investigación y extensión. Se destaca por su enfoque práctico y su estrecha vinculación con la industria, lo que garantiza que sus egresados estén bien preparados para afrontar los desafíos del mundo laboral.
""";

class OpenMapMinimapScreen extends StatelessWidget {
  const OpenMapMinimapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OpenMaps minimap'),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('UTN.BA', style: TextStyle(fontSize: 20)),
              Text(
                _utnDescription,
                textAlign: TextAlign.justify,
              ),
              Row(
                children: [
                  _UtnContactInfo(),
                  SizedBox(width: 10),
                  Expanded(child: _UtnMinimap()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _UtnMinimap extends StatelessWidget {
  const _UtnMinimap();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      clipBehavior: Clip.hardEdge,
      child: const OpenMinimap(
        height: 200,
        zoom: 16,
        centerLocation: utnMedranoLatLng,
        marker: Icon(
          Icons.location_on,
          color: Colors.red,
          size: 40,
        ),
      ),
    );
  }
}

class _UtnContactInfo extends StatelessWidget {
  const _UtnContactInfo();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            FaIcon(FontAwesomeIcons.locationDot, size: 14),
            SizedBox(width: 6),
            Text(
              'Medrano 951, CABA',
              style: TextStyle(fontSize: 10),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            FaIcon(FontAwesomeIcons.phone, size: 14),
            SizedBox(width: 6),
            Text(
              '+54 11 4867-7500',
              style: TextStyle(fontSize: 10),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            FaIcon(FontAwesomeIcons.globe, size: 14),
            SizedBox(width: 6),
            Text(
              'https://frba.utn.edu.ar',
              style: TextStyle(fontSize: 10),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            FaIcon(FontAwesomeIcons.envelope, size: 14),
            SizedBox(width: 6),
            Text(
              'consultas@frba.utn.edu.ar',
              style: TextStyle(fontSize: 10),
            ),
          ],
        ),
      ],
    );
  }
}
