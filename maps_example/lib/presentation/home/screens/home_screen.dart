import 'package:flutter/material.dart';
import 'package:maps_example/presentation/home/models/menu_item.dart';
import 'package:maps_example/presentation/home/widgets/menu_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Maps Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Google Maps'),
            ...googleMapsItems.map(
              (item) => MenuItemWidget(item: item),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Divider(),
            ),
            const Text('Open Maps'),
            ...openMapsItems.map(
              (item) => MenuItemWidget(item: item),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Divider(),
            ),
            const Text('Map UX'),
            ...mapUxItems.map(
              (item) => MenuItemWidget(item: item),
            ),
          ],
        ),
      ),
    );
  }
}
