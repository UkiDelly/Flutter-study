import 'package:flutter/material.dart';
import 'package:flutter_study/common/basic_screen.dart';
import 'package:flutter_study/common/colors.dart';

class RootTab extends StatefulWidget {
  const RootTab({super.key});

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return BasicScreen(
      title: "코팩 딜리버리",
      child: Center(
        child: Text("Root tab"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: primaryColor,
        unselectedItemColor: bodyTextColor,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => setState(() => this.index = index),
        currentIndex: index,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.fastfood_outlined), label: '음식'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long_outlined), label: '주문'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: '프로필'),
        ],
      ),
    );
  }
}
