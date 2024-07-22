import 'package:firebase_movies_app/presentation/login/screens/login_screen.dart';
import 'package:firebase_movies_app/presentation/movie_details/screens/movie_details_screen.dart';
import 'package:firebase_movies_app/presentation/nav/screens/nav_screen.dart';
import 'package:firebase_movies_app/presentation/signup/screens/signup_screen.dart';
import 'package:firebase_movies_app/presentation/splash/screens/splash_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static final AppRoutes _singleton = AppRoutes._internal();

  factory AppRoutes() {
    return _singleton;
  }

  AppRoutes._internal();

  static Map<String, Widget Function(BuildContext)> getRoutes() {
    return {
      SplashScreen.routeName: (_) => const SplashScreen(),
      LoginScreen.routeName: (_) => const LoginScreen(),
      SignupScreen.routeName: (_) => const SignupScreen(),
      NavScreen.routeName: (_) => const NavScreen(),
      MovieDetailsScreen.routeName: (_) => const MovieDetailsScreen(),
    };
  }
}
