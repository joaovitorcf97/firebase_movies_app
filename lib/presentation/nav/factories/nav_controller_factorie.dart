import 'package:firebase_movies_app/data/repositories/api_respository/i_api_repository.dart';
import 'package:firebase_movies_app/data/repositories/movies/get_movies_repository.dart';
import 'package:firebase_movies_app/presentation/nav/controllers/nav_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/movies/get_movie_repository.dart';

ChangeNotifierProvider<NavController> makeNavController(BuildContext context) {
  return ChangeNotifierProvider<NavController>(
    create: (_) => NavController(
      GetMoviesRepository(
        Provider.of<IApiRepository>(context),
        GetMovieRepository(Provider.of<IApiRepository>(context)),
      ),
    ),
  );
}
