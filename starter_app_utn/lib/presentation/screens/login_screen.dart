import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:starter_app_utn/domain/movie.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController inputController = TextEditingController();

  String inputText = '';

  final myMovie =
      Movie(rating: 10, title: 'El Padrino', description: 'Una gran película');
  final myMovie2 = Movie(
    rating: 10,
    title: 'El Padrino',
    description: 'Una gran película',
    director: 'Francis Ford Coppola',
  );

  final movieList = [
    Movie(rating: 10, title: 'El Padrino', description: 'Una gran película'),
    Movie(rating: 9, title: 'El Padrino II', description: 'Una gran película'),
    Movie(rating: 8, title: 'El Padrino III', description: 'Una gran película'),
    Movie(rating: 7, title: 'El Padrino IV', description: 'Una gran película'),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(myMovie);
    print(myMovie2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            inputText,
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: inputController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nombre',
                hintText: 'Ingrese su nombre',
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: () {
                //context.go('/home');
                //context.push('/home', extra: 'El nombre es Juancito');
                //context.push('/home/El nombre es Juancito');
                inputText = inputController.text;
                setState(() {});
              },
              child: const Text('Login')),
        ],
      ),
    ));
  }
}
