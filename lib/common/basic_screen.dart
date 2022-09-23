import 'package:flutter/material.dart';

class BasicScreen extends StatelessWidget {
  final Color? backgroundColor;
  final Widget child;
  final String? title;
  final BottomNavigationBar? bottomNavigationBar;
  const BasicScreen({super.key, required this.child, this.backgroundColor, this.title, this.bottomNavigationBar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: renderAppBar(),
      backgroundColor: backgroundColor ?? Colors.white,
      body: child,
      bottomNavigationBar: bottomNavigationBar,
    );
  }

  AppBar? renderAppBar() {
    if (title == null) {
      return null;
    } else {
      return AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        title: Text(
          title!,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      );
    }
  }
}
