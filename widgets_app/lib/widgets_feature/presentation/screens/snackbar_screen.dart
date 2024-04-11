import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SnackbarScreen extends StatelessWidget {
  static const name = 'snackbar_screen';
  const SnackbarScreen({super.key});

  void showSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    final snackbar = SnackBar(
      duration: const Duration(seconds: 1),
      content: const Text('A snackbar has been shown'),
      action: SnackBarAction(
        label: 'Ok',
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Snackbar Screen'),
      ),
      body: const _SnackbarView(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showSnackbar(context),
        label: const Text('Show Snackbar'),
        icon: const Icon(Icons.remove_red_eye_outlined),
      ),
    );
  }
}

class _SnackbarView extends StatelessWidget {
  const _SnackbarView();

  void openDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Are you sure?'),
              content: const Text(
                  'Excepteur minim laboris duis incididunt nisi exercitation ut nisi non cupidatat. Incididunt proident adipisicing quis nulla occaecat eu id elit pariatur labore ad exercitation. Lorem voluptate labore est deserunt.'),
              actions: [
                TextButton(
                    onPressed: () {
                      context.pop();
                    },
                    child: const Text('CANCEL')),
                FilledButton(
                    onPressed: () {
                      context.pop();
                    },
                    child: const Text('OK')),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        FilledButton.tonal(
            onPressed: () {
              showAboutDialog(context: context, children: [
                const Text(
                    'Ut excepteur magna do Lorem ullamco veniam commodo ad laborum non consectetur nulla exercitation deserunt. Ullamco aliqua culpa ipsum sunt adipisicing voluptate elit in non cillum id et aute. Cupidatat officia tempor consequat minim exercitation nostrud Lorem.'),
              ]);
            },
            child: const Text('About Digalog')),
        const SizedBox(height: 10),
        FilledButton.tonal(
          onPressed: () {
            openDialog(context);
          },
          child: const Text('Custom Dialog'),
        ),
      ]),
    );
  }
}
