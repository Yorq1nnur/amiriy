import 'package:amiriy/utils/images/app_images.dart';
import 'package:flutter/material.dart';
import 'package:my_utils/my_utils.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppImages.amiriy,
            width: double.infinity-120.w,
            height: 190.h,
            fit: BoxFit.fill,
            color: Colors.red,
            colorBlendMode: BlendMode.srcIn,
          ),
        ],
      ),
    );
  }
}
