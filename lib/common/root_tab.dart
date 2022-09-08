import 'package:flutter/material.dart';
import 'package:flutter_study/common/basic_screen.dart';

class RootTab extends StatelessWidget {
  const RootTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BasicScreen(
        child: Center(
      child: Text("Root tab"),
    ));
  }
}
