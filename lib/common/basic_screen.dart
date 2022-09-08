import 'package:flutter/material.dart';

class BasicScreen extends StatelessWidget {
  final Color? backgroundColor;
  final Widget child;
  const BasicScreen({super.key, required this.child, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: backgroundColor ?? Colors.white,
      body: child,
    );
  }
}
