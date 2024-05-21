import 'dart:convert';
import 'package:amiriy/bloc/bottom/bottom_bloc.dart';
import 'package:amiriy/bloc/bottom/bottom_event.dart';
import 'package:amiriy/bloc/bottom/bottom_state.dart';
import 'package:amiriy/bloc/notification/notification_bloc.dart';
import 'package:amiriy/bloc/notification/notification_event.dart';
import 'package:amiriy/data/models/notification_model.dart';
import 'package:amiriy/permissions/app_permissions.dart';
import 'package:amiriy/screens/routes.dart';
import 'package:amiriy/screens/tabs/book/books_screen.dart';
import 'package:amiriy/screens/tabs/categories/categories_screen.dart';
import 'package:amiriy/screens/tabs/settings/settings_screen.dart';
import 'package:amiriy/screens/widgets/my_notification_button.dart';
import 'package:amiriy/services/local_notification_service.dart';
import 'package:amiriy/utils/colors/app_colors.dart';
import 'package:amiriy/utils/images/app_images.dart';
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
      const CategoriesScreen(),
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
          return Stack(
            children: [
              IndexedStack(
                index: state.index,
                children: screens,
              ),
              if (showMessage)
                NotificationMyButton(
                  messageTitle: messageTitle,
                  onTab: () {
                    Navigator.pushNamed(
                      context,
                      RouteNames.notificationScreen,
                    );
                  },
                ),
            ],
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<BottomBloc, ChangeIndexState>(
        builder: (context, state) {
          return BottomNavigationBar(
            selectedItemColor: AppColors.black,
            currentIndex: state.index,
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              context.read<BottomBloc>().add(ChangeIndexEvent(
                    index: index,
                  ));
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
                  colorFilter:
                      const ColorFilter.mode(AppColors.black, BlendMode.srcIn),
                  height: 24.h,
                  width: 24.h,
                ),
                label: "",
              ),
              BottomNavigationBarItem(
                activeIcon: SvgPicture.asset(
                  AppImages.search,
                  colorFilter:
                      const ColorFilter.mode(AppColors.black, BlendMode.srcIn),
                  height: 24.h,
                  width: 24.h,
                ),
                icon: SvgPicture.asset(
                  AppImages.search,
                  height: 24.h,
                  width: 24.h,
                ),
                label: "",
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
