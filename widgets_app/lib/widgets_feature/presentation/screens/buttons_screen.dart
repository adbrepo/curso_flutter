import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ButtonsScreen extends StatelessWidget {
  static const name = 'buttons_screen';
  const ButtonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buttons'),
      ),
      body: const _ButtonsView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pop();
        },
        child: const Icon(Icons.keyboard_return_outlined),
      ),
    );
  }
}

class _ButtonsView extends StatelessWidget {
  const _ButtonsView();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return SizedBox(
      width: double.infinity,
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Wrap(
            spacing: 10,
            alignment: WrapAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: const Text('Elevated button'),
              ),
              const ElevatedButton(
                onPressed: null,
                child: Text('elevated disabled'),
              ),
              ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.access_alarm),
                  label: const Text('Elevated icon')),
              FilledButton(
                onPressed: () {},
                child: const Text('Filled button'),
              ),
              FilledButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add_reaction),
                  label: const Text('Filled icon')),
              TextButton(
                onPressed: () {},
                child: const Text('Text button'),
              ),
              TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.airplay_sharp),
                  label: const Text('Text icon')),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.app_registration_rounded)),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.add_a_photo_outlined),
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(colors.primary),
                  iconColor: MaterialStatePropertyAll(colors.onPrimary),
                ),
              ),
            ],
          )),
    );
  }
}
