import 'package:amiriy/utils/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_utils/my_utils.dart';

class GlobalWithIconButton extends StatelessWidget {
  const GlobalWithIconButton(
      {super.key,
      required this.onTap,
      required this.icon,
      required this.title,
      this.verticalPadding = 8,
      this.horizontalPadding = 16,
      this.colorText = Colors.white,
      this.verticalTextPadding = 13,
      this.horizontalTextPadding = 13,
      this.width = 100,
      this.height = 45,
      this.borderRadius = 6,
      this.fontSize = 14});

  final VoidCallback onTap;
  final String title;
  final String icon;
  final Color colorText;
  final int horizontalPadding;
  final int verticalPadding;
  final int verticalTextPadding;
  final int horizontalTextPadding;
  final int width;
  final int height;
  final int borderRadius;
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
        width: width.w,
        height: height.h,
        child: TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(
                vertical: verticalTextPadding.h,
                horizontal: horizontalTextPadding.w),
            backgroundColor: AppColors.c1A72DD,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius.w),
            ),
          ),
          onPressed: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(icon),
              SizedBox(
                width: 10.w,
              ),
              Text(title,
                  style: TextStyle(fontSize: fontSize.w, color: colorText)),
            ],
          ),
        ),
      ),
    );
  }
}
