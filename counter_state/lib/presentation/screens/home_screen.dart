import 'package:counter_state/presentation/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {

    final counter  = ref.watch(counterProvider);


    return   Scaffold(
      body: Center(
        child: Text(
          'Counter: $counter',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

           ref.read(counterProvider.notifier).state ++;
          // Alternatively, you can use:
          // ref.read(counterProvider.notifier).increment();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}