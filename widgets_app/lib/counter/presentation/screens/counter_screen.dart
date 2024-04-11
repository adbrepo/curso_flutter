import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgets_app/counter/presentation/providers/counter_provider.dart';
import 'package:widgets_app/config/theme/presentation/providers/theme_provider.dart';

class CounterScreen extends ConsumerWidget {
  static const name = 'counter_screen';

  const CounterScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int counterValue = ref.watch(counterProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter'),
      ),
      body: Center(
          child: Text(
        'Valor : $counterValue',
        style: Theme.of(context).textTheme.displayMedium,
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(counterProvider.notifier).state++;
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
