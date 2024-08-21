import 'package:firebase_movies_app/core/config/app_colors.dart';
import 'package:firebase_movies_app/core/enums/sizes_enum.dart';
import 'package:firebase_movies_app/core/extensions/ui/media_query_extension.dart';
import 'package:firebase_movies_app/core/extensions/ui/sizes_extension.dart';
import 'package:firebase_movies_app/core/widgets/sized_box/sized_box_widget.dart';
import 'package:firebase_movies_app/core/widgets/texts/text_widget.dart';
import 'package:flutter/material.dart';

typedef OnTapNavButton = void Function();

class NavButtonWidget extends StatelessWidget {
  final String label;
  final IconData icon;
  final OnTapNavButton onTap;
  final bool isSelected;

  const NavButtonWidget({
    super.key,
    required this.icon,
    required this.onTap,
    required this.isSelected,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? AppColors.secondaryColor : AppColors.whiteColor;

    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: context.getWidth / 3,
        child: Column(
          children: [
            Icon(
              icon,
              color: color,
              size: SizesEnum.xl.getSize,
            ),
            const SizedBoxWidget.xxs(),
            TextWidget.small(
              label,
              color: color,
            ),
          ],
        ),
      ),
    );
  }
}
