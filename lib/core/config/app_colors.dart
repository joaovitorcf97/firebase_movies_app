import 'package:flutter/material.dart';

class AppColors {
  static final AppColors _singleton = AppColors._internal();

  factory AppColors() {
    return _singleton;
  }

  AppColors._internal();

  // Black
  static Color get primaryColor => const Color(0xFF0f0e11);

  // Blue
  static Color get secondaryColor => const Color(0xFF2962ff);

  // Red
  static Color get errorColor => const Color(0xFFdd3545);
  static Color get favoriteColor => Colors.redAccent;

  // White
  static Color get whiteColor => const Color(0xFFFFFFFF);

  // Green
  static Color get successColor => Colors.green;
}
