import 'package:amiriy/utils/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:my_utils/my_utils.dart';

class GlobalSimpleButton extends StatelessWidget {
  const GlobalSimpleButton({
    super.key,
    required this.onTap,
    required this.title,
    this.verticalPadding = 8,
    this.horizontalPadding = 16,
    this.colorText = Colors.white,
    this.verticalTextPadding = 13,
    this.horizontalTextPadding = 13,
    this.fontSize = 14,
  });

  final VoidCallback onTap;
  final String title;
  final Color colorText;
  final int horizontalPadding;
  final int verticalPadding;
  final int verticalTextPadding;
  final int horizontalTextPadding;
  final int fontSize;

  // final double widthButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding.w,
        vertical: verticalPadding.h,
      ),
      child: SizedBox(
        child: TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(
                vertical: verticalTextPadding.h,
                horizontal: horizontalTextPadding.w),
            backgroundColor: AppColors.c1A72DD,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.w),
            ),
          ),
          onPressed: onTap,
          child: Text(title,
              style: TextStyle(fontSize: fontSize.w, color: colorText)),
        ),
      ),
    );
  }
}
