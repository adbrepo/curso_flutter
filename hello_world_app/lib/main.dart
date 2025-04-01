import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  String label = 'Initial Label';

  @override
  Widget build(BuildContext context) {
    debugPrint(label);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontSize: 34),
                ),
                FilledButton(
                  onPressed: () {
                    setState(() {
                      label = 'New text';
                      debugPrint(label);
                    });
                  },
                  child: const Text('Click Me'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
