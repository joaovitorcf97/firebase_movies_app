import 'package:firebase_movies_app/core/const/assets_paths_const.dart';
import 'package:firebase_movies_app/core/enums/sizes_enum.dart';
import 'package:firebase_movies_app/core/extensions/ui/sizes_extension.dart';
import 'package:firebase_movies_app/core/mixins/loading_error_mixin.dart';
import 'package:firebase_movies_app/core/mixins/navigation_mixin.dart';
import 'package:firebase_movies_app/core/mixins/snack_bat_mixin.dart';
import 'package:firebase_movies_app/core/widgets/sized_box/sized_box_widget.dart';
import 'package:firebase_movies_app/core/widgets/texts/text_widget.dart';
import 'package:firebase_movies_app/presentation/login/mixins/login_focus_node_mixin.dart';
import 'package:firebase_movies_app/presentation/login/mixins/login_text_editing_controller.dart';
import 'package:firebase_movies_app/presentation/nav/screens/nav_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../controllers/login_controller.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with
        LoginFocusNodeMixin,
        LoginTextEditingController,
        NavigationMixin,
        LoadingErrorMixin,
        SnackBatMixin {
  late LoginController loginController;

  @override
  void initState() {
    loginController = LoginController();
    setIsLoading(false);

    super.initState();
  }

  void onLogin() async {
    setIsLoading(true);

    final error = await loginController.onLogin(
      emailTec.text,
      passwordTec.text,
    );

    if (error != null && context.mounted) {
      showSnackBar(context, error, MessageType.error);
    } else {
      handleNavigation(context, NavScreen.routeName, clear: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: loginController.loginFormKey,
        child: Padding(
          padding: EdgeInsets.all(SizesEnum.lg.getSize),
          child: SizedBox.expand(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 150,
                  height: 150,
                  child: Lottie.asset(AssetsPathsConst.animationLogin),
                ),
                const SizedBoxWidget.sm(),
                TextWidget.title('Firebase Movies App'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
