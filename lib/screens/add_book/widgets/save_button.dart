import 'package:amiriy/utils/colors/app_colors.dart';
import 'package:amiriy/utils/styles/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 10.h,
          ),
          margin: EdgeInsets.symmetric(
            horizontal: 30.w,
          ),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(
              16.r,
            ),
          ),
          child: Center(
            child: Text(
              "SAVE",
              style: AppTextStyle.interBold.copyWith(
                color: AppColors.black,
                fontSize: 20.sp,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ));
  }
}
