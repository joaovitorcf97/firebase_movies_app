import 'package:firebase_movies_app/core/config/app_colors.dart';
import 'package:flutter/material.dart';

class AppMaterialDart {
  static final AppMaterialDart _singleton = AppMaterialDart._internal();

  factory AppMaterialDart() {
    return _singleton;
  }

  AppMaterialDart._internal();

  static const String title = 'Firebase Movies App';

  static const Locale locale = Locale('pt-br');

  static ThemeData get getTheme => ThemeData(
        scaffoldBackgroundColor: AppColors.primaryColor,
        primaryColor: AppColors.primaryColor,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primaryColor,
          titleTextStyle: TextStyle(
            color: AppColors.whiteColor,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          centerTitle: true,
          elevation: 0,
        ),
        fontFamily: 'Lato',
      );
}
