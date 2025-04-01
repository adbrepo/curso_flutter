import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/providers/counter_provider.dart';
import 'package:riverpod_example/providers/names_provider.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});

//  int counter = 0;

  @override
  Widget build(BuildContext context, ref) {
    final counter = ref.watch(counterProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Riverpod Example'),
      ),
      body: //CounterScreen(counter: counter),
          NamesScreen(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //counter++;
          ref.read(counterProvider.notifier).state++;
          ref.read(namesProvider.notifier).state.add('otro valor mas');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class NamesScreen extends ConsumerWidget {
  // List<String> names = [
  //   'John',
  //   'Doe',
  //   'Jane',
  //   'Smith',
  //   'Alice',
  // ];

  NamesScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    final names = ref.watch(namesProvider);

    return ListView.builder(
      itemCount: names.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(names[index]),
        );
      },
    );
  }
}

class CounterScreen extends StatelessWidget {
  const CounterScreen({
    super.key,
    required this.counter,
  });

  final int counter;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Counter: $counter',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
