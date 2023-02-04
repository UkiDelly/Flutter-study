import 'package:flutter/material.dart';
import 'package:flutter_study/provider_screen.dart';
import 'package:provider/provider.dart';

import 'provider/counter_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => Counter()),
    ], child: const MaterialApp(title: 'Flutter study', home: ExampleHomeScreen()));
  }
}
