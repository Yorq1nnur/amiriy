import 'package:amiriy/screens/global_widgets/global_text.dart';
import 'package:amiriy/utils/colors/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_utils/my_utils.dart';

class CategoryButton extends StatelessWidget {
  const CategoryButton({
    super.key,
    required this.voidCallback,
    required this.title, required this.isTranslate,
  });

  final VoidCallback voidCallback;
  final String title;
  final bool isTranslate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 3.w,
        vertical: 3.h,
      ),
      child: InkWell(
        onTap: voidCallback,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 10.w,
            vertical: 15.h,
          ),
          margin: EdgeInsets.all(2.w),
          decoration: BoxDecoration(
            color: AppColors.cF1F1F1,
            borderRadius: BorderRadius.circular(20),
          ),
          child: GlobalText(
            data:  isTranslate?title.tr() : title,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            isTranslate: false,
          ),
        ),
      ),
    );
  }
}
