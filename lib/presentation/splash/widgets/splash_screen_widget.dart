import 'package:firebase_movies_app/core/const/assets_paths_const.dart';
import 'package:firebase_movies_app/core/mixins/navigation_mixin.dart';
import 'package:firebase_movies_app/core/services/firebase/firebase_auth_service.dart';
import 'package:firebase_movies_app/core/widgets/sized_box/sized_box_widget.dart';
import 'package:firebase_movies_app/core/widgets/texts/text_widget.dart';
import 'package:firebase_movies_app/presentation/login/screens/login_screen.dart';
import 'package:firebase_movies_app/presentation/nav/screens/nav_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

class SplashScreenWidget extends StatefulWidget {
  const SplashScreenWidget({super.key});

  @override
  State<SplashScreenWidget> createState() => _SplashScreenWidgetState();
}

class _SplashScreenWidgetState extends State<SplashScreenWidget>
    with NavigationMixin {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(seconds: 2));
      final user = FirebaseAuthService.getUser;

      if (context.mounted) {
        if (user == null) {
          handleNavigation(context, LoginScreen.routeName, clear: true);
        } else {
          Navigator.of(context).pushReplacement(_createRoute());
        }
      }
    });

    super.initState();
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secodaryAnimation) => const NavScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = 0.0;
        const end = 1.0;
        const curve = Curves.easeInOut;

        final tween = Tween(begin: begin, end: end);
        final curverdAnimamtion = CurvedAnimation(
          parent: animation,
          curve: curve,
        );

        return FadeTransition(
          opacity: tween.animate(curverdAnimamtion),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 100,
            height: 100,
            child: Lottie.asset(AssetsPathsConst.animationSplash),
          ),
          const SizedBoxWidget.md(),
          TextWidget.title('Loading...'),
        ],
      ),
    );
  }
}
