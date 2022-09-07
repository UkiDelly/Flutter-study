import 'package:flutter/material.dart';
import 'package:flutter_study/common/custom_text_from_field.dart';
import 'package:flutter_study/view/login_screen.dart';

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
        theme: ThemeData(fontFamily: 'NotoSans'),

        //
        home: const LoginScreen());
  }
}


// Server Repo
// "https://github.com/codefactory-co/flutter-lv2-server"


// Flutter repo

// "https://github.com/codefactory-co/flutter-lv2-rest-api"