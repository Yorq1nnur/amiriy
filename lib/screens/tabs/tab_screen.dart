import 'dart:convert';

import 'package:amiriy/bloc/bottom/bottom_bloc.dart';
import 'package:amiriy/bloc/bottom/bottom_state.dart';
import 'package:amiriy/screens/tabs/settings/settings_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../bloc/bottom/bottom_event.dart';
import '../../bloc/notification/notification_bloc.dart';
import '../../bloc/notification/notification_event.dart';
import '../../data/models/notification_model.dart';
import '../../permissions/app_permissions.dart';
import '../../services/local_notification_service.dart';
import 'book/books_screen.dart';
import 'categories/categories_screen.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  List<Widget> screens = const [
    CategoriesScreen(),
    BooksScreen(),
    SettingsScreen(),
  ];
  String messageTitle = "";

  bool showMessage = false;

  @override
  void initState() {
    AppPermissions();

    _getMyToken();
    _getPermission();
    super.initState();
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

          await Future.delayed(const Duration(seconds: 3));
          showMessage = false;
          setState(() {});
        }
      },
    );
  }

  _getPermission() async {
    await Permission.notification.isDenied.then((value) {
      if (value) {
        Permission.notification.request();
      }
    });
    await Permission.camera.isDenied.then((value) {
      if (value) {
        Permission.notification.request();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocBuilder<BottomBloc, ChangeIndexState>(
        builder: (context, state) {
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
            currentIndex: state.index,
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              context.read<BottomBloc>().add(
                    ChangeIndexEvent(
                      index: index,
                    ),
                  );
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.category,
                  color: Colors.black,
                  size: 20.w,
                ),
                label: "Categories",
                activeIcon: Icon(
                  Icons.category,
                  color: Colors.blue,
                  size: 30.w,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.book,
                  color: Colors.black,
                  size: 20.w,
                ),
                label: "Books",
                activeIcon: Icon(
                  Icons.book,
                  color: Colors.blue,
                  size: 30.w,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                  color: Colors.black,
                  size: 20.w,
                ),
                label: "Settings",
                activeIcon: Icon(
                  Icons.settings,
                  color: Colors.blue,
                  size: 30.w,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
