import 'package:firebase_movies_app/core/config/app_colors.dart';
import 'package:firebase_movies_app/core/widgets/sized_box/sized_box_widget.dart';
import 'package:firebase_movies_app/core/widgets/texts/text_widget.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String label;
  final bool isBlock;
  final bool isLoading;
  final void Function() onPressed;

  const ButtonWidget({
    super.key,
    required this.label,
    this.isBlock = true,
    this.isLoading = false,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.secondaryColor.withOpacity(
              isLoading ? .6 : 1,
            ),
            fixedSize: isBlock ? Size(constraints.maxWidth, 50) : null,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            elevation: 0,
          ),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!isLoading) ...[
                TextWidget.bold(label),
              ],
              if (isLoading) ...[
                const SizedBoxWidget.md(),
                SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: AppColors.whiteColor,
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
