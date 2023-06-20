import 'package:flutter/material.dart';

hexStringToColor(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF" + hexColor;
  }
  return Color(int.parse(hexColor, radix: 16));
}

Color whitetheme = hexStringToColor('FFFFFF');
Color primarytheme = hexStringToColor('120161');
Color secondarytheme = hexStringToColor('D5CDFE');
Color orangetheme = hexStringToColor('FFA751');
Color peachtheme = hexStringToColor('FFE1D5');
