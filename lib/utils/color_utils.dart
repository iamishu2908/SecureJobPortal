import 'package:flutter/material.dart';

hexStringToColor(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF" + hexColor;
  }
  return Color(int.parse(hexColor, radix: 16));
}

Color whitetheme = hexStringToColor('FFFFFF');
Color primarytheme = hexStringToColor('130160');
Color secondarytheme = hexStringToColor('D5CDFE');
Color orangetheme = hexStringToColor('FFA751');
Color peachtheme = hexStringToColor('FFE1D5');
Color greytheme = hexStringToColor('F4F3F6');
const Color correct = Color(0xFF32AB58);
const Color incorrect = Color(0xFFAB3232);
const Color neutral = Color(0xFFE7E7E7);
const Color background = Color(0xFF143464);

// convert_color(String hexa) {
//   int col = ("0x$hexa").toString() as int;
//   return MaterialColor(col, <int, Color>{
//     50: Color(col),
//     100: Color(col),
//     200: Color(col),
//     300: Color(col),
//     400: Color(col),
//     500: Color(col),
//     600: Color(col),
//     700: Color(col),
//     800: Color(col),
//     900: Color(col),
//   });
// }
