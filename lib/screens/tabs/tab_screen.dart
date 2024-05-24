// import 'dart:convert';
// import 'package:amiriy/bloc/auth/auth_bloc.dart';
// import 'package:amiriy/bloc/auth/auth_state.dart';
// import 'package:amiriy/bloc/bottom/bottom_bloc.dart';
// import 'package:amiriy/bloc/bottom/bottom_state.dart';
// import 'package:amiriy/bloc/form_status/form_status.dart';
// import 'package:amiriy/bloc/notification/notification_bloc.dart';
// import 'package:amiriy/bloc/notification/notification_event.dart';
// import 'package:amiriy/data/models/notification_model.dart';
// import 'package:amiriy/permissions/app_permissions.dart';
// import 'package:amiriy/screens/global_widgets/custom_navigation_bar.dart';
// import 'package:amiriy/screens/routes.dart';
// import 'package:amiriy/screens/tabs/book/books_screen.dart';
// import 'package:amiriy/screens/tabs/search/search_screen.dart';
// import 'package:amiriy/screens/tabs/settings/settings_screen.dart';
// import 'package:amiriy/services/local_notification_service.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// class TabScreen extends StatefulWidget {
//   const TabScreen({super.key});
//
//   @override
//   State<TabScreen> createState() => _TabScreenState();
// }
//
// class _TabScreenState extends State<TabScreen> {
//   String messageTitle = "";
//
//   bool showMessage = false;
//
//   _getPermission() async {
//     await Permission.notification.isDenied.then((value) {
//       if (value) {
//         Permission.notification.request();
//       }
//     });
//   }
//
//   late List<Widget> screens = [];
//
//   @override
//   void initState() {
//     AppPermissions();
//     screens = [
//       const BooksScreen(),
//       const SearchScreen(),
//       const BooksScreen(),
//       const SettingsScreen(),
//     ];
//
//     _getMyToken();
//     _getPermission();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocBuilder<BottomBloc, ChangeIndexState>(
//         builder: (context, state) {
//           BlocListener<AuthBloc, AuthState>(
//             listener: (p, c) {
//               if (c.status == FormStatus.unauthenticated) {
//                 Navigator.pushNamedAndRemoveUntil(
//                   context,
//                   RouteNames.loginRoute,
//                   (context) => false,
//                 );
//               }
//             },
//             child: const SizedBox.shrink(),
//           );
//           return Stack(
//             children: [
//               IndexedStack(
//                 index: state.index,
//                 children: screens,
//               ),
//               Align(
//                 alignment: Alignment.bottomCenter,
//                 child: CustomBottomNavigationBar(
//                   currentIndex: 0,
//                   items: [
//                     CustomBottomNavigationBarItem(
//                       icon: Icons.home,
//                       label: 'Home',
//                       activeColor: Colors.blue,
//                       inactiveColor: Colors.grey,
//                     ),
//                     CustomBottomNavigationBarItem(
//                       icon: Icons.search,
//                       label: 'Search',
//                       activeColor: Colors.blue,
//                       inactiveColor: Colors.grey,
//                     ),
//                     CustomBottomNavigationBarItem(
//                       icon: Icons.book,
//                       label: 'Books',
//                       activeColor: Colors.blue,
//                       inactiveColor: Colors.grey,
//                     ),
//                     CustomBottomNavigationBarItem(
//                       icon: Icons.settings,
//                       label: 'Settings',
//                       activeColor: Colors.blue,
//                       inactiveColor: Colors.grey,
//                     ),
//                   ],
//                   onTap: (index) {
//                     // Handle item tap
//                   },
//                 ),
//               )
//             ],
//           );
//         },
//       ),
//     );
//   }
//
//   _getMyToken() async {
//     FirebaseMessaging.onMessage.listen(
//       (RemoteMessage remote) async {
//         if (remote.notification!.title != null) {
//           debugPrint("${remote.notification!.body!}   ------------");
//           NotificationModel notificationModel = NotificationModel.fromJson(
//               jsonDecode(remote.notification!.body!));
//
//           context.read<NotificationBloc>().add(
//                 NotificationInsertEvent(notificationModel: notificationModel),
//               );
//
//           LocalNotificationService.localNotificationService.showNotification(
//             title: notificationModel.title,
//             body: notificationModel.description,
//             id: 1,
//           );
//
//           showMessage = true;
//           messageTitle = notificationModel.title;
//           setState(() {});
//
//           await Future.delayed(
//             const Duration(
//               seconds: 3,
//             ),
//           );
//           showMessage = false;
//           setState(() {});
//         }
//       },
//     );
//   }
// }

import 'dart:math';
import 'package:amiriy/screens/tabs/book/books_screen.dart';
import 'package:amiriy/screens/tabs/books/books_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_utils/my_utils.dart';
import 'search/search_screen.dart';
import 'settings/settings_screen.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late AnimationController _controller;
  late Animation<double> _animation;

  late List<Widget> screens;

  @override
  void initState() {
    screens = const [
      BooksScreen(),
      SearchScreen(),
      BookScreen(),
      SettingsScreen(),
    ];
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _controller.forward(from: 0.0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildAnimatedIcon(IconData icon, int index) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        double animationValue = _animation.value;
        return Stack(
          alignment: Alignment.center,
          children: [
            if (_selectedIndex == index)
              ...List.generate(4, (i) {
                double angle = (i * 90.0) * (3.14 / 180.0);
                return Transform.translate(
                  offset: Offset(
                    animationValue * 20 * cos(angle),
                    animationValue * 20 * sin(angle),
                  ),
                  child: Container(
                    width: 8.0,
                    height: 8.0,
                    decoration:  BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                );
              }),
            Icon(icon, color: Theme.of(context).iconTheme.color, size: Theme.of(context).iconTheme.size,),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: _buildAnimatedIcon(Icons.home, 0),
            label: 'home'.tr(),
          ),
          BottomNavigationBarItem(
            icon: _buildAnimatedIcon(Icons.search, 1),
            label: 'search'.tr(),
          ),
          BottomNavigationBarItem(
            icon: _buildAnimatedIcon(Icons.book, 2),
            label: 'category'.tr(),
          ),
          BottomNavigationBarItem(
            icon: _buildAnimatedIcon(Icons.settings, 3),
            label: 'settings'.tr(),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

