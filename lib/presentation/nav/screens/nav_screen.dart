import 'package:firebase_movies_app/core/services/firebase/firebase_store_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/factories/make_video_player.dart';
import '../factories/make_movies_widget_controller_factory.dart';
import '../factories/nav_controller_factorie.dart';
import '../widgets/nav/nav_screen_widget.dart';

class NavScreen extends StatelessWidget {
  static const String routeName = '/nav';

  const NavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        makeNavController(context),
        makeVideoPlayer,
        makeMoviesWidgetController,
        StreamProvider.value(
          value: FirebaseStoreService().getFavoriteMovies,
          initialData: null,
        ),
      ],
      child: const NavScreenWidget(),
    );
  }
}
