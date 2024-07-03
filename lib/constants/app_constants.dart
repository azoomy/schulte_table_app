import 'package:flutter/material.dart';

class AppColors {
  static const Color mainColor = Color(0xFFb8d8d8);
  static const Color secondaryColor = Color(0xFF7a9e9f);
  static const Color lightColor = Color(0xFFeef5db);
  static const Color pinkColor = Color(0xFFf35f55);
  static const Color darkColor = Color(0xFF4f6367);

  static LinearGradient scaffoldColor = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 0.5, 1.0],
    colors: [
      darkColor,
      secondaryColor,
      mainColor,
    ],
  );
}

class AppTitles {
  TextStyle header = const TextStyle(
      color: AppColors.lightColor, fontWeight: FontWeight.bold, fontSize: 24);
  TextStyle subtitle = const TextStyle(
      color: AppColors.lightColor, fontWeight: FontWeight.bold, fontSize: 20);
  TextStyle text = const TextStyle(
      color: AppColors.lightColor, fontWeight: FontWeight.w500, fontSize: 14);
  TextStyle footer = const TextStyle(
      color: AppColors.darkColor, fontWeight: FontWeight.w100, fontSize: 12);
  TextStyle tableNumber = const TextStyle(
      color: AppColors.darkColor, fontWeight: FontWeight.bold, fontSize: 50);
}
