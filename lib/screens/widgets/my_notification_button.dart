import 'package:amiriy/utils/colors/app_colors.dart';
import 'package:amiriy/utils/styles/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:my_utils/my_utils.dart';

class NotificationMyButton extends StatelessWidget {
  const NotificationMyButton({
    super.key,
    required this.onTab,
    required this.messageTitle,
  });

  final VoidCallback onTab;
  final String messageTitle;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onPressed: onTab,
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 30,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Text(
            messageTitle,
            style: AppTextStyle.interBold.copyWith(
              color: AppColors.black,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
