import 'package:firebase_movies_app/core/const/assets_paths_const.dart';
import 'package:firebase_movies_app/core/enums/sizes_enum.dart';
import 'package:firebase_movies_app/core/extensions/ui/sizes_extension.dart';
import 'package:firebase_movies_app/core/mixins/loading_error_mixin.dart';
import 'package:firebase_movies_app/core/mixins/navigation_mixin.dart';
import 'package:firebase_movies_app/core/mixins/snack_bat_mixin.dart';
import 'package:firebase_movies_app/core/validators/email_validator.dart';
import 'package:firebase_movies_app/core/widgets/buttons/button_widget.dart';
import 'package:firebase_movies_app/core/widgets/sized_box/sized_box_widget.dart';
import 'package:firebase_movies_app/core/widgets/texts/inputs/text_form_field_widget.dart';
import 'package:firebase_movies_app/core/widgets/texts/text_widget.dart';
import 'package:firebase_movies_app/presentation/login/mixins/login_focus_node_mixin.dart';
import 'package:firebase_movies_app/presentation/login/mixins/login_text_editing_controller.dart';
import 'package:firebase_movies_app/presentation/nav/screens/nav_screen.dart';
import 'package:firebase_movies_app/presentation/signup/screens/signup_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../core/validators/password_validator.dart';
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

  void onLogin(BuildContext context) async {
    setIsLoading(true);

    final error = await loginController.onLogin(
      emailTec.text,
      passwordTec.text,
    );

    if (error != null && context.mounted) {
      setIsLoading(false);
      showSnackBar(context, error, MessageType.error);
    } else {
      handleNavigation(context, NavScreen.routeName, clear: true);
    }
  }

  @override
  void dispose() {
    disposeFN();
    disposeLoginTec();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: loginController.loginFormKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: SizesEnum.lg.getSize),
          child: SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height - 150,
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 150,
                    height: 150,
                    child: Lottie.asset(AssetsPathsConst.animationLogin),
                  ),
                  const SizedBoxWidget.md(),
                  TextWidget.title('Firebase Movies App'),
                  const SizedBoxWidget.md(),
                  TextFormFieldWidget(
                    inputLabel: 'E-mail',
                    controller: emailTec,
                    focusNode: emailFN,
                    validator: EmailValidator.validate,
                    textInputType: TextInputType.emailAddress,
                    onFieldSubmitted: (_) => passwordFN.requestFocus,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBoxWidget.md(),
                  TextFormFieldWidget(
                    inputLabel: 'Senha',
                    controller: passwordTec,
                    focusNode: passwordFN,
                    isPassword: true,
                    validator: PasswordValidator.validate,
                    onFieldSubmitted: (_) => onLogin(context),
                    textInputAction: TextInputAction.go,
                  ),
                  const SizedBoxWidget.xxl(),
                  ButtonWidget(
                    label: 'Login',
                    onPressed: () => onLogin(context),
                    isBlock: true,
                    isLoading: isLoading,
                  ),
                  const SizedBoxWidget.lg(),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: const TextStyle(fontSize: 16),
                      children: [
                        const TextSpan(
                          text: 'Ainda não possui conta? ',
                        ),
                        TextSpan(
                          text: 'Registre aqui!',
                          style: const TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => handleNavigation(
                                  context,
                                  SignupScreen.routeName,
                                ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
