import 'package:flutter/material.dart';

mixin LoginTextEditingController {
  final emailTec = TextEditingController();
  final passwordTec = TextEditingController();

  void disposeLoginTec() {
    emailTec.dispose();
    passwordTec.dispose();
  }
}
