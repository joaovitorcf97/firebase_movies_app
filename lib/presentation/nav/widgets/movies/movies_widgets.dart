import 'package:firebase_movies_app/core/mixins/loading_error_mixin.dart';
import 'package:firebase_movies_app/core/services/video_player/i_video_player.dart';
import 'package:firebase_movies_app/presentation/nav/controllers/movies_widget_controller.dart';
import 'package:firebase_movies_app/presentation/nav/controllers/nav_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../../../../core/widgets/others/error_with_button_widget.dart';
import 'movies_cinema_seats_image_widget.dart';
import 'movies_youtube_player_widget.dart';

class MoviesWidgets extends StatefulWidget {
  const MoviesWidgets({super.key});

  @override
  State<MoviesWidgets> createState() => _MoviesWidgetsState();
}

class _MoviesWidgetsState extends State<MoviesWidgets> with LoadingErrorMixin {
  final _moviesCarouselCtrl = PageController(viewportFraction: 0.4);

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _moviesCarouselCtrl.addListener(changeVideoPageListener);
        getMoviesAndInitVideo();
      },
    );
  }

  void changeVideoPageListener() {
    final navCtrl = Provider.of<NavController>(context, listen: false);
    final moviesWidgetCtrl = Provider.of<MoviesWidgetController>(
      context,
      listen: false,
    );

    setState(() {
      moviesWidgetCtrl.currentPage = _moviesCarouselCtrl.page ?? 0;
    });

    if (moviesWidgetCtrl.currentPage.round() == moviesWidgetCtrl.currentPage) {
      initvideo(
        navCtrl.moviesList[moviesWidgetCtrl.currentPage.round()].videoId,
      );
    }
  }

  void initvideo([String? videoId]) async {
    final navCtrl = Provider.of<NavController>(context, listen: false);
    final videoPlayerController =
        Provider.of<IVideoPlayer<YoutubePlayerController>>(
      context,
      listen: false,
    );

    final firstVideoWithId = navCtrl.moviesList.firstWhere(
      (video) => video.videoId != null,
    );

    videoPlayerController.load(videoId ?? firstVideoWithId.videoId!);
  }

  Future<void> getMoviesAndInitVideo() async {
    final navCtrl = Provider.of<NavController>(context, listen: false);

    setError(null);
    setIsLoading(true);

    final error = await navCtrl.getMovies();

    setIsLoading(false);
    setError(error);

    if (error == null) {
      initvideo();
    }
  }

  @override
  Widget build(BuildContext context) {
    final navCtrl = Provider.of<NavController>(context);
    final moviesWidgetCtrl = Provider.of<MoviesWidgetController>(context);

    return OrientationBuilder(
      builder: (_, orientation) {
        final isPortrait = orientation == Orientation.portrait;

        return errorMessage != null
            ? ErrorWithButtonWidget(
                errorMessage: errorMessage!,
                tryAgain: () {},
              )
            : Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  if (!isLoading)
                    MoviesYoutubePlayerWidget(isPortrait: isPortrait),
                  if (isPortrait) const MoviesCinemaSeatsImageWidget(),
                  if (isLoading)
                    const Center(
                      child: CircularProgressIndicator(),
                    )
                ],
              );
      },
    );
  }
}
