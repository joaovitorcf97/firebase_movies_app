import 'package:firebase_movies_app/core/config/app_colors.dart';
import 'package:firebase_movies_app/core/widgets/texts/text_widget.dart';
import 'package:flutter/material.dart';

enum MessageType { success, error }

mixin SnackBatMixin {
  void showSnackBar(
    BuildContext context,
    String message,
    MessageType messageType,
  ) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: TextWidget.normal(message),
          backgroundColor: messageType == MessageType.error
              ? AppColors.errorColor
              : AppColors.successColor,
        ),
      );
  }
}
