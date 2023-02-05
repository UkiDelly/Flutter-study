import 'package:flutter/material.dart';

class NestedScrollViewWidget extends StatelessWidget {
  const NestedScrollViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return <Widget>[];
      },
      body: Container(),
    );
  }
}
