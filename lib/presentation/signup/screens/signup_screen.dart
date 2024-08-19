import 'package:firebase_movies_app/core/extensions/ui/sizes_extension.dart';
import 'package:firebase_movies_app/core/mixins/loading_error_mixin.dart';
import 'package:firebase_movies_app/core/mixins/navigation_mixin.dart';
import 'package:firebase_movies_app/presentation/nav/screens/nav_screen.dart';
import 'package:firebase_movies_app/presentation/signup/mixins/signup_focus_node_mixin.dart';
import 'package:firebase_movies_app/presentation/signup/mixins/signup_text_editing_controller_mixin.dart';
import 'package:flutter/material.dart';

import '../../../core/enums/sizes_enum.dart';
import '../../../core/mixins/snack_bat_mixin.dart';
import '../../../core/validators/email_validator.dart';
import '../../../core/validators/password_validator.dart';
import '../../../core/widgets/buttons/button_widget.dart';
import '../../../core/widgets/sized_box/sized_box_widget.dart';
import '../../../core/widgets/texts/inputs/text_form_field_widget.dart';
import '../../../core/widgets/texts/text_widget.dart';
import '../controllers/signup_controller.dart';

class SignupScreen extends StatefulWidget {
  static const String routeName = '/signup';
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen>
    with
        NavigationMixin,
        LoadingErrorMixin,
        SignupFocusNodeMixin,
        SignupTextEditingControllerMixin,
        SnackBatMixin {
  late SignupController signupController;
  @override
  void initState() {
    super.initState();
    setIsLoading(false);
    signupController = SignupController();
  }

  void onSignup(BuildContext context) async {
    setIsLoading(true);
    setError(null);

    final (errorMessage, success) = await signupController.onSignup(
      emailTec.text,
      passwordTec.text,
    );

    if (success && context.mounted) {
      handleNavigation(context, NavScreen.routeName, clear: true);
    } else {
      setIsLoading(false);
      if (errorMessage != null) {
        showSnackBar(context, errorMessage, MessageType.error);
      }
    }
  }

  @override
  void dispose() {
    disposeLoginTec();
    disposeFN();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
          key: signupController.signupFormKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: SizesEnum.lg.getSize,
                  ),
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height - 150,
                  ),
                  alignment: Alignment.topLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBoxWidget.md(),
                      TextWidget.title('Regristro'),
                      const SizedBoxWidget.sm(),
                      TextWidget.normal(
                        'Digite um e-mail e senha para criar sua nova conta.',
                      ),
                      const SizedBoxWidget.xxl(),
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
                        onFieldSubmitted: (_) => onSignup(context),
                        textInputAction: TextInputAction.go,
                      ),
                      const SizedBoxWidget.xxl(),
                      ButtonWidget(
                        label: 'Registrar',
                        onPressed: () => onSignup(context),
                        isBlock: true,
                        isLoading: isLoading,
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
