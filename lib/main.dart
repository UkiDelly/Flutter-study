import 'package:flutter/material.dart';

void main() {
  runApp(const _MyApp());
}

class _MyApp extends StatelessWidget {
  const _MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Container(),
        ));
  }
}


// Server Repo
// "https://github.com/codefactory-co/flutter-lv2-server"


// Flutter repo

// "https://github.com/codefactory-co/flutter-lv2-rest-api"