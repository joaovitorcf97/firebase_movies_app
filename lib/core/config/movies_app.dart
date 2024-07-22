import 'package:firebase_movies_app/core/config/app_initial_bindings.dart';
import 'package:firebase_movies_app/core/config/app_material.dart';
import 'package:firebase_movies_app/core/config/app_routes.dart';
import 'package:firebase_movies_app/presentation/splash/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MoviesApp extends StatelessWidget {
  const MoviesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: AppInitialBindings.dependencies(),
      child: MaterialApp(
        title: AppMaterialDart.title,
        theme: AppMaterialDart.getTheme,
        initialRoute: SplashScreen.routeName,
        routes: AppRoutes.getRoutes(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
