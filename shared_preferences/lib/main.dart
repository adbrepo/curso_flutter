import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();

    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  await asyncPrefs.setBool('repeat', true);
                  await asyncPrefs.setString('action', 'Start');
                },
                child: Text('Store'),
              ),
              ElevatedButton(
                onPressed: () async {
                  final bool? repeat = await asyncPrefs.getBool('repeat');
                  final String? action = await asyncPrefs.getString('action');

                  print('repeat: $repeat');
                  print('action: $action');
                },
                child: Text('Show'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
