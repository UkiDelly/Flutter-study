import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_lecture/riverpod/provider_observer.dart';
import 'package:riverpod_lecture/screen/home_screen.dart';

void main() {
  runApp(
    ProviderScope(
      // ProviderScope 하위에 모든 Provider에 Observer가 적용된다.
      observers: [Logger()],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}
