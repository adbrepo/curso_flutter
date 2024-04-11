import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedScreen extends StatefulWidget {
  static const name = 'animated_screen';
  const AnimatedScreen({super.key});

  @override
  State<AnimatedScreen> createState() => _AnimatedScreenState();
}

class _AnimatedScreenState extends State<AnimatedScreen> {
  double height = 100;
  double width = 100;
  double borderRadius = 8;
  Color color = Colors.green;

  void changeShape() {
    final random = Random();
    height = random.nextDouble() * 300;
    width = random.nextDouble() * 300;
    borderRadius = random.nextDouble() * 100;
    color = Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Animated Screen'),
        ),
        body: Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOutCubic,
            width: width,
            height: height,
            decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(borderRadius)),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            changeShape();
          },
          child: const Icon(Icons.play_arrow_outlined),
        ));
  }
}
