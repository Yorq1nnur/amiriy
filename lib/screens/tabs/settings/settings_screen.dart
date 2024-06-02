import 'package:amiriy/bloc/auth/auth_bloc.dart';
import 'package:amiriy/bloc/auth/auth_event.dart';
import 'package:amiriy/bloc/image/image_bloc.dart';
import 'package:amiriy/screens/global_widgets/global_text.dart';
import 'package:amiriy/screens/routes.dart';
import 'package:amiriy/utils/colors/app_colors.dart';
import 'package:amiriy/utils/images/app_images.dart';
import 'package:amiriy/utils/sizedbox/get_sizedbox.dart';
import 'package:amiriy/utils/utility_functions/utility_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_utils/my_utils.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    super.key,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: GlobalText(
          data: 'settings',
          fontSize: 20.sp,
          fontWeight: FontWeight.w900,
          isTranslate: true,
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthBloc>().add(
                    LogOutUserEvent(),
                  );
            },
            icon: Icon(
              Icons.logout,
              size: Theme.of(context).iconTheme.size,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
          20.getW(),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 20.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  RouteNames.editProfileRoute,
                ).then((v) async {
                  context.read<ImageBloc>().add(
                        ChangeInitialState(),
                      );
                  await Future.delayed(
                    const Duration(
                      seconds: 1,
                    ),
                  );
                  if (context.mounted) {
                    UtilityFunctions.methodPrint(
                      'ON IMAGE INITIAL STATE IMAGE IS: ${context.read<ImageBloc>().state}',
                    );
                  }
                });
              },
              borderRadius: BorderRadius.circular(
                10,
              ),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 25.w,
                  vertical: 25.h,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                  color: AppColors.cCA5A5A.withOpacity(
                    0.1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      AppImages.tabProfile,
                      height: 30.w,
                      width: 30.w,
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).iconTheme.color!,
                        BlendMode.srcIn,
                      ),
                    ),
                    GlobalText(
                      data: 'edit_profile',
                      fontSize: 16.w,
                      fontWeight: FontWeight.w700,
                      isTranslate: true,
                      textAlign: TextAlign.start,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Theme.of(context).iconTheme.color!,
                    ),
                  ],
                ),
              ),
            ),
            20.getH(),
            InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  RouteNames.languagesRoute,
                ).then((v) {
                  setState(() {});
                });
              },
              borderRadius: BorderRadius.circular(
                10,
              ),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 25.w,
                  vertical: 25.h,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                  color: AppColors.cCA5A5A.withOpacity(
                    0.1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      AppImages.language,
                      height: 30.w,
                      width: 30.w,
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).iconTheme.color!,
                        BlendMode.srcIn,
                      ),
                    ),
                    GlobalText(
                      data: 'language',
                      fontSize: 16.w,
                      fontWeight: FontWeight.w700,
                      isTranslate: true,
                      textAlign: TextAlign.start,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Theme.of(context).iconTheme.color!,
                    ),
                  ],
                ),
              ),
            ),
            20.getH(),
            InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  RouteNames.contactUs,
                );
              },
              borderRadius: BorderRadius.circular(
                10,
              ),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 25.w,
                  vertical: 25.h,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                  color: AppColors.cCA5A5A.withOpacity(
                    0.1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      AppImages.contactUs,
                      height: 30.w,
                      width: 30.w,
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).iconTheme.color!,
                        BlendMode.srcIn,
                      ),
                    ),
                    GlobalText(
                      data: 'contact_us',
                      fontSize: 16.w,
                      fontWeight: FontWeight.w700,
                      isTranslate: true,
                      textAlign: TextAlign.start,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Theme.of(context).iconTheme.color!,
                    ),
                  ],
                ),
              ),
            ),
            20.getH(),
            InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  RouteNames.theme,
                );
              },
              borderRadius: BorderRadius.circular(
                10,
              ),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 25.w,
                  vertical: 25.h,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                  color: AppColors.cCA5A5A.withOpacity(
                    0.1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      AppImages.theme,
                      height: 30.w,
                      width: 30.w,
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).iconTheme.color!,
                        BlendMode.srcIn,
                      ),
                    ),
                    GlobalText(
                      data: 'change_theme',
                      fontSize: 16.w,
                      fontWeight: FontWeight.w700,
                      isTranslate: true,
                      textAlign: TextAlign.start,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Theme.of(context).iconTheme.color!,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
