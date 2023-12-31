import 'package:flutter/material.dart';

class TColor {
  static Color get primaryColor1 => const Color(0xffF09932);
  static Color get primaryColor2 => const Color(0xffFFDCB2);

  static Color get secondaryColor1 => const Color(0xff6131AD);
  static Color get secondaryColor2 => const Color(0xffD4B9FF);

  static List<Color> get primaryG => [primaryColor2, primaryColor1];
  static List<Color> get secondaryG => [secondaryColor2, secondaryColor1];

  static Color get black => const Color(0xff1D1617);
  static Color get gray => const Color(0xff786F72);
  static Color get white => Colors.white;
  static Color get lightGray => const Color(0xffF7F8F8);
  static Color get red => const Color.fromARGB(255, 255, 0, 0);
}
