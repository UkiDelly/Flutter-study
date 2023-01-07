import 'package:flutter/material.dart';
import 'package:rive_splash_screen/rive_splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Rive',
        home: SplashScreen.navigate(
            name: 'assets/nodegen.riv',
            next: (_) => const Home(),
            until: () => Future.delayed(const Duration()),
            startAnimation: 'appear',
            backgroundColor: Colors.black));
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Rive'),
      ),
      body: const Text("body", style: TextStyle(fontSize: 30, color: Colors.white)),
    );
  }
}
