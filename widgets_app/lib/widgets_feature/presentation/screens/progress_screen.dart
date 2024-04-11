import 'package:flutter/material.dart';

class ProgresScreen extends StatelessWidget {
  static const name = 'progress_screen';
  const ProgresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress indicators'),
      ),
      body: const _ProgressView(),
    );
  }
}

class _ProgressView extends StatelessWidget {
  const _ProgressView();

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Column(
      children: [
        SizedBox(height: 10),
        Text('Circular progress indicator'),
        SizedBox(height: 10),
        CircularProgressIndicator(
          strokeWidth: 2,
          backgroundColor: Colors.black26,
        ),
        SizedBox(height: 20),
        Text('Controlled circular  & linear progress indicator'),
        SizedBox(height: 10),
        _ControlledIndicator()
      ],
    ));
  }
}

class _ControlledIndicator extends StatelessWidget {
  const _ControlledIndicator();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Stream.periodic(const Duration(milliseconds: 300), (value) {
          return (value * 2) / 100;
        }).takeWhile((value) => value < 1.0),
        builder: (context, snapshot) {
          final progressValue = snapshot.data ?? 0;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              CircularProgressIndicator(
                value: progressValue.toDouble(),
                strokeWidth: 2,
                backgroundColor: Colors.black26,
              ),
              const SizedBox(width: 20),
              Expanded(
                child: LinearProgressIndicator(
                  value: progressValue.toDouble(),
                  backgroundColor: Colors.black26,
                ),
              )
            ]),
          );
        });
  }
}
