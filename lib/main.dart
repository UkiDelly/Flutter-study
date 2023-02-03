import 'package:flutter/material.dart';
import 'package:flutter_study/test_list_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter study',
      home: Scaffold(
        body: SafeArea(
          child: SizedBox(height: 200, child: TestListView()),
        ),
      ),
    );
  }
}
