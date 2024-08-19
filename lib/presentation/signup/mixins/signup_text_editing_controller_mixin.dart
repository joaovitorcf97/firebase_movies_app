import 'package:flutter/material.dart';

mixin SignupTextEditingControllerMixin {
  final emailTec = TextEditingController();
  final passwordTec = TextEditingController();

  void disposeLoginTec() {
    emailTec.dispose();
    passwordTec.dispose();
  }
}
