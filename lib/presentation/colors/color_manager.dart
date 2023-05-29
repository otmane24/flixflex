import 'package:flutter/material.dart';

class ColorManager {
  static Color primary = HexColor.formHex("#0C0F3B");
  static Color secondary = HexColor.formHex("#8C2EFF");
  static Color darkGrey = HexColor.formHex("#4F4F5F");
  static Color light = HexColor.formHex("#F6F6F6");
}

extension HexColor on Color {
  static Color formHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = "FF$hexColorString";
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
