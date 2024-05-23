import 'dart:convert';
import 'package:amiriy/bloc/auth/auth_bloc.dart';
import 'package:amiriy/bloc/auth/auth_state.dart';
import 'package:amiriy/bloc/bottom/bottom_bloc.dart';
import 'package:amiriy/bloc/bottom/bottom_event.dart';
import 'package:amiriy/bloc/bottom/bottom_state.dart';
import 'package:amiriy/bloc/form_status/form_status.dart';
import 'package:amiriy/bloc/notification/notification_bloc.dart';
import 'package:amiriy/bloc/notification/notification_event.dart';
import 'package:amiriy/data/models/notification_model.dart';
import 'package:amiriy/permissions/app_permissions.dart';
import 'package:amiriy/screens/routes.dart';
import 'package:amiriy/screens/tabs/book/books_screen.dart';
import 'package:amiriy/screens/tabs/search/search_screen.dart';
import 'package:amiriy/screens/tabs/settings/settings_screen.dart';
import 'package:amiriy/services/local_notification_service.dart';
import 'package:amiriy/utils/colors/app_colors.dart';
import 'package:amiriy/utils/images/app_images.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_utils/my_utils.dart';
import 'package:permission_handler/permission_handler.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  String messageTitle = "";

  bool showMessage = false;

  _getPermission() async {
    await Permission.notification.isDenied.then((value) {
      if (value) {
        Permission.notification.request();
      }
    });
  }

  late List<Widget> screens = [];

  @override
  void initState() {
    AppPermissions();
    screens = [
      const BooksScreen(),
      const SearchScreen(),
      const BooksScreen(),
      const SettingsScreen(),
    ];

    _getMyToken();
    _getPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BottomBloc, ChangeIndexState>(
        builder: (context, state) {
          BlocListener<AuthBloc, AuthState>(
            listener: (p, c) {
              if (c.status == FormStatus.unauthenticated) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  RouteNames.loginRoute,
                  (context) => false,
                );
              }
            },
            child: const SizedBox.shrink(),
          );
          return Stack(
            children: [
              IndexedStack(
                index: state.index,
                children: screens,
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<BottomBloc, ChangeIndexState>(
        builder: (context, state) {
          return BottomNavigationBar(
            selectedItemColor: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
            unselectedItemColor: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
            selectedFontSize: 15.w,
            unselectedFontSize: 14.w,
            currentIndex: state.index,
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              switch (index) {
                case (0):
                  context.read<BottomBloc>().add(
                        ChangeIndexEvent(
                          index: 0,
                        ),
                      );
                  break;
                case (1):
                  context.read<BottomBloc>().add(
                        ChangeIndexEvent(
                          index: 1,
                        ),
                      );
                  break;
                case (2):
                  context.read<BottomBloc>().add(
                        ChangeIndexEvent(
                          index: 2,
                        ),
                      );
                  break;
                case (3):
                  context.read<BottomBloc>().add(
                        ChangeIndexEvent(
                          index: 3,
                        ),
                      );
                  break;
              }
            },
            items: [
              BottomNavigationBarItem(
                activeIcon: SvgPicture.asset(
                  AppImages.home,
                  colorFilter:
                      const ColorFilter.mode(AppColors.black, BlendMode.srcIn),
                  height: 24.h,
                  width: 24.h,
                ),
                icon: SvgPicture.asset(
                  AppImages.home,
                  colorFilter: const ColorFilter.mode(
                    AppColors.black,
                    BlendMode.srcIn,
                  ),
                  height: 24.h,
                  width: 24.h,
                ),
                label: "home".tr(),
              ),
              BottomNavigationBarItem(
                activeIcon: SvgPicture.asset(
                  AppImages.search,
                  colorFilter: const ColorFilter.mode(
                    AppColors.black,
                    BlendMode.srcIn,
                  ),
                  height: 24.h,
                  width: 24.h,
                ),
                icon: SvgPicture.asset(
                  AppImages.search,
                  height: 24.h,
                  width: 24.h,
                  colorFilter: const ColorFilter.mode(
                    Colors.black54,
                    BlendMode.srcIn,
                  ),
                ),
                label: "search".tr(),
              ),
              BottomNavigationBarItem(
                activeIcon: SvgPicture.asset(
                  AppImages.books,
                  colorFilter:
                      const ColorFilter.mode(AppColors.black, BlendMode.srcIn),
                  height: 24.h,
                  width: 24.h,
                ),
                icon: SvgPicture.asset(
                  AppImages.books,
                  height: 24.h,
                  width: 24.h,
                  colorFilter: const ColorFilter.mode(
                    Colors.grey,
                    BlendMode.srcIn,
                  ),
                ),
                label: "books".tr(),
              ),
              BottomNavigationBarItem(
                activeIcon: SvgPicture.asset(
                  AppImages.settings,
                  colorFilter:
                      const ColorFilter.mode(AppColors.black, BlendMode.srcIn),
                  height: 24.h,
                  width: 24.h,
                ),
                icon: SvgPicture.asset(
                  AppImages.settings,
                  height: 24.h,
                  width: 24.h,
                  colorFilter: const ColorFilter.mode(
                    Colors.grey,
                    BlendMode.srcIn,
                  ),
                ),
                label: "settings".tr(),
              ),
            ],
          );
        },
      ),
    );
  }

  _getMyToken() async {
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage remote) async {
        if (remote.notification!.title != null) {
          debugPrint("${remote.notification!.body!}   ------------");
          NotificationModel notificationModel = NotificationModel.fromJson(
              jsonDecode(remote.notification!.body!));

          context.read<NotificationBloc>().add(
                NotificationInsertEvent(notificationModel: notificationModel),
              );

          LocalNotificationService.localNotificationService.showNotification(
            title: notificationModel.title,
            body: notificationModel.description,
            id: 1,
          );

          showMessage = true;
          messageTitle = notificationModel.title;
          setState(() {});

          await Future.delayed(
            const Duration(
              seconds: 3,
            ),
          );
          showMessage = false;
          setState(() {});
        }
      },
    );
  }
}
