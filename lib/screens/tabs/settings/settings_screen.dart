import 'package:amiriy/screens/routes.dart';
import 'package:amiriy/utils/images/app_images.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../utils/colors/app_colors.dart';
import '../../../utils/styles/app_text_style.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Settings",
            style: AppTextStyle.interBold.copyWith(
              color: AppColors.black,
              fontSize: 20.sp,
              fontWeight: FontWeight.w900,
            ),
          ),
          actions: [
            ZoomTapAnimation(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  RouteNames.newsRoute,
                );
              },
              child: SvgPicture.asset(
                AppImages.news,
                width: 24.w,
                height: 24.h,
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
          ],
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: user?.photoURL == null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(
                      16.r,
                    ),
                    child: Image.network(
                      "https://www.tenforums.com/attachments/tutorials/146359d1501443008-change-default-account-picture-windows-10-a-user.png",
                      height: 24.h,
                      width: 24.w,
                      fit: BoxFit.cover,
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(
                      16.r,
                    ),
                    child: Image.network(
                      user!.photoURL!,
                      height: 24.h,
                      width: 24.w,
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}