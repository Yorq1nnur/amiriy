import 'package:amiriy/screens/auth/widgets/global_textbutton.dart';
import 'package:amiriy/screens/global_widgets/global_text.dart';
import 'package:amiriy/screens/routes.dart';
import 'package:amiriy/utils/images/app_images.dart';
import 'package:amiriy/utils/sizedbox/get_sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:my_utils/my_utils.dart';

import '../../data/local/storage_repository.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.sizeOf(context).height;
    width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 50.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(
                16,
              ),
              child: Image.asset(
                AppImages.amiriy,
                width: double.infinity,
                height: 200.h,
                fit: BoxFit.fill,
              ),
            ),
            50.getH(),
            GlobalText(
              data: 'library_amiriy',
              fontSize: 30.w,
              fontWeight: FontWeight.w700,
              isTranslate: true,
            ),
            GlobalText(
              data: "on_boarding",
              fontSize: 18.w,
              fontWeight: FontWeight.w400,
              isTranslate: true,
            ),
            60.getH(),
            GlobalTextButton(
              onTap: () async {
                setState(() {
                  isLoading = !isLoading;
                });
                await StorageRepository.setBool(
                  key: 'is_new_user',
                  value: true,
                );
                await Future.delayed(const Duration(seconds: 1));
                if (context.mounted) {
                  Navigator.pushReplacementNamed(
                    context,
                    RouteNames.loginRoute,
                  );
                }
              },
              text: "get_started",
              isLoading: isLoading,
              isTranslate: true,
            ),
          ],
        ),
      ),
    );
  }
}
