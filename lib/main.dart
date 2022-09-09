import 'package:flutter/material.dart';

import 'package:flutter_study/data/color_data.dart';
import 'package:flutter_study/view/persmission/permission_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,

        // Theme
        theme: ThemeData(
          primarySwatch: createMaterialColor(mainColor),
          errorColor: errorColor,
        ),

        //

        title: '노라죠',
        home: const PermissionScreen());
  }
}
