import 'package:firebase_movies_app/core/config/app_colors.dart';
import 'package:firebase_movies_app/core/enums/sizes_enum.dart';
import 'package:firebase_movies_app/core/extensions/ui/media_query_extension.dart';
import 'package:firebase_movies_app/core/extensions/ui/sizes_extension.dart';
import 'package:firebase_movies_app/core/services/video_player/i_video_player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class MoviesYoutubePlayerWidget extends StatelessWidget {
  final bool isPortrait;

  const MoviesYoutubePlayerWidget({super.key, required this.isPortrait});

  @override
  Widget build(BuildContext context) {
    final videoPlayerController =
        Provider.of<IVideoPlayer<YoutubePlayerController>>(
      context,
      listen: false,
    );

    return Positioned(
      width: context.getWidth,
      height: context.getHeight,
      top: -context.getHeight * .25,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isPortrait ? SizesEnum.sm.getSize : 0,
        ),
        child: YoutubePlayer(
          controller: videoPlayerController.getController,
          aspectRatio: 1,
          backgroundColor: AppColors.primaryColor,
        ),
      ),
    );
  }
}
