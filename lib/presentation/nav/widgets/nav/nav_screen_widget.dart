import 'dart:ui';

import 'package:firebase_movies_app/core/config/app_colors.dart';
import 'package:firebase_movies_app/core/enums/sizes_enum.dart';
import 'package:firebase_movies_app/core/extensions/ui/media_query_extension.dart';
import 'package:firebase_movies_app/core/extensions/ui/sizes_extension.dart';
import 'package:firebase_movies_app/core/mixins/navigation_mixin.dart';
import 'package:firebase_movies_app/core/services/firebase/firebase_auth_service.dart';
import 'package:firebase_movies_app/core/services/video_player/i_video_player.dart';
import 'package:firebase_movies_app/core/widgets/texts/text_widget.dart';
import 'package:firebase_movies_app/presentation/login/screens/login_screen.dart';
import 'package:firebase_movies_app/presentation/nav/controllers/nav_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../movies/movies_widgets.dart';
import 'nav_button_widget.dart';

class NavScreenWidget extends StatefulWidget {
  const NavScreenWidget({super.key});

  @override
  State<NavScreenWidget> createState() => _NavScreenWidgetState();
}

class _NavScreenWidgetState extends State<NavScreenWidget>
    with NavigationMixin {
  late NavController navCtrl;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      navCtrl.addListener(navTabIndexChane);
    });
  }

  void navTabIndexChane() {
    final videoPlayer = Provider.of<IVideoPlayer<YoutubePlayerController>>(
      context,
      listen: false,
    );

    if (navCtrl.navIndex == 0) {
      videoPlayer
        ..getController.unMute()
        ..play();
    } else {
      videoPlayer
        ..mute()
        ..pause();
    }
  }

  void onLogout(BuildContext context) async {
    final String? error = await FirebaseAuthService.logout();

    if (error == null && context.mounted) {
      handleNavigation(context, LoginScreen.routeName, clear: true);
    }
  }

  @override
  void dispose() {
    super.dispose();

    navCtrl.removeListener(navTabIndexChane);
  }

  @override
  Widget build(BuildContext context) {
    navCtrl = context.watch<NavController>();

    return Scaffold(
      appBar: AppBar(
        title: TextWidget.normal('Título'),
        actions: [
          IconButton(
            onPressed: () => onLogout(context),
            icon: const Icon(
              Icons.logout,
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          const Expanded(
            child: Center(
              child: MoviesWidgets(),
            ),
          ),
          if (navCtrl.navIndex == 1)
            Expanded(
              child: Container(
                color: Colors.red,
                child: Center(
                  child: TextWidget.normal('Favorites'),
                ),
              ),
            ),
          if (navCtrl.navIndex == 2)
            Expanded(
              child: Container(
                color: Colors.green,
                child: Center(
                  child: TextWidget.normal('Profile'),
                ),
              ),
            ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: .0, sigmaY: 5.0),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(.7),
                    border: Border(
                      top: BorderSide(
                        color: AppColors.primaryColor, // Cor da borda
                        width: 1.0, // Largura da borda
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: SizesEnum.xxs.getSize,
                      bottom: SizesEnum.xs.getSize + context.getBottomPadding,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        NavButtonWidget(
                          label: 'Movies',
                          icon: Icons.movie,
                          onTap: () => navCtrl.selectNavIndex(0),
                          isSelected: navCtrl.navIndex == 0,
                        ),
                        NavButtonWidget(
                          label: 'Favorites',
                          icon: Icons.favorite,
                          onTap: () => navCtrl.selectNavIndex(1),
                          isSelected: navCtrl.navIndex == 1,
                        ),
                        NavButtonWidget(
                          label: 'Profile',
                          icon: Icons.person,
                          onTap: () => navCtrl.selectNavIndex(2),
                          isSelected: navCtrl.navIndex == 2,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
