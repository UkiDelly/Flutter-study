import 'package:flutter/material.dart';

const mainColor = Color(0xff2c64f7);
const secondColor = Color(0xffd2e1ff);
const gray1 = Color(0xffe8e8e8);
const gray2 = Color(0xffbababa);

const mainTextColor = Color(0xff676767);
const placeHolderTextColor = Color(0xffbcbcbc);
const errorColor = Color(0xffc87979);

const buttonPressedColor = Color(0xffa5bded);
const buttonDisabledColor = Color(0xff676767);

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}
