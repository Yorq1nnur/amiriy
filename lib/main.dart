import 'package:amiriy/data/local/local_database.dart';
import 'package:amiriy/screens/app/app.dart';
import 'package:amiriy/services/local_notification_service.dart';
import 'package:amiriy/utils/constants/app_constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'data/local/storage_repository.dart';
import 'services/firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint(
      "BACKGROUND MODE DA PUSH NOTIFICATION KELDI:${message.notification!.title}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.instance.subscribeToTopic("news");
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  LocalNotificationService.localNotificationService.init();
  LocalDatabase.databaseInstance;

  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );

  await StorageRepository.init();
  runApp(
    EasyLocalization(
      saveLocale: true,
      supportedLocales: const [
        Locale("en", "US"),
        Locale("uz", "UZ"),
        Locale("ru", "RU"),
        Locale('uz', 'RU'),
      ],
      path: AppConstants.translations,
      startLocale: const Locale(
        "uz",
        "UZ",
      ),
      child: App(),
    ),
  );
}

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
// import 'package:amiriy/screens/tabs/book/categories_screen.dart';
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
