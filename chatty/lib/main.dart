import 'package:chatty/common/routes/pages.dart';
import 'package:chatty/common/style/style.dart';
import 'package:chatty/common/utils/FirebaseMassagingHandler.dart';
import 'package:chatty/global/global.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

void main() async {
  await Global.init();

  runApp(const MyApp());

  await firebaseChatInit()
      .whenComplete(() => FirebaseMessagingHandler.config());
}

Future firebaseChatInit() async {
  FirebaseMessaging.onBackgroundMessage(FirebaseMessagingHandler.firebaseMessagingBackground);

  if (GetPlatform.isAndroid) {
    FirebaseMessagingHandler.flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(FirebaseMessagingHandler.channel_call);

    FirebaseMessagingHandler.flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(FirebaseMessagingHandler.channel_message);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 780),
        builder: (context, child) => GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Chatty .',
              theme: AppTheme.light,
              initialRoute: AppPages.INITIAL,
              getPages: AppPages.routes,
              builder: EasyLoading.init(),
            ));
  }
}
