import 'dart:ui';

import 'package:flutter/material.dart';

class CustomColors {
  static Color white = Colors.white;
  static Color teal = Colors.teal;
  static Color black = Colors.black;
  static Color yellow = Color.fromARGB(255, 142, 107, 24);
  static Color green = Color(0xFF2A6E3F);
  static Color green1 = Color(0xFF007D62);
  static Color green2 = Color(0xFF1C8D6C);
  static Color green3 = Color(0xFF53976F);
  static Color green4 = Color(0xFF6BB392);
  static Color green5 = Color(0xFF68945C);

  static Color lightGreen2 = Color(0xFF799A64);
  static Color lightGreen3 = Color(0xFF91AE84);
  static Color lightGreen4 = Color(0xFF8EAF8C);
  static Color lightGreen5 = Color(0xFF8DB799);
  static LinearGradient greenGradient = LinearGradient(
    colors: [
      CustomColors.green,
      CustomColors.green1,
      CustomColors.green2,
      CustomColors.green3,
      CustomColors.green4,
    ],
  );
  static LinearGradient lightGreenGradient = LinearGradient(
    colors: [
      CustomColors.green5,
      CustomColors.lightGreen2,
      CustomColors.lightGreen3,
      CustomColors.lightGreen4,
      CustomColors.lightGreen5,
    ],
  );
}
