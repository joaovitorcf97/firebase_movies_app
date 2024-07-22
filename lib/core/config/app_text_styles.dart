import 'package:firebase_movies_app/core/config/app_colors.dart';
import 'package:flutter/material.dart';

class AppTextStyles {
  static final AppTextStyles _singleton = AppTextStyles._internal();

  factory AppTextStyles() {
    return _singleton;
  }
  AppTextStyles._internal();

  static TextStyle get getNormalStyle => TextStyle(
        color: AppColors.whiteColor,
        fontSize: 14,
      );

  static TextStyle get getNormalBoldStyle => getNormalStyle.copyWith(
        fontWeight: FontWeight.bold,
      );

  static TextStyle get getTitleStyle => getNormalBoldStyle.copyWith(
        fontSize: 24,
      );

  static TextStyle get getSmallStyle => getNormalBoldStyle.copyWith(
        fontSize: 12,
      );
}
