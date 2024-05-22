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
      supportedLocales: const [
        Locale("eng", "ENG"),
        Locale("uz", "UZ"),
        Locale("ru", "RU"),
        Locale("kr", "KR"),
      ],
      path: AppConstants.translations,
      fallbackLocale: const Locale(
        "eng",
        "ENG",
      ),
      child: App(),
    ),
  );
}
