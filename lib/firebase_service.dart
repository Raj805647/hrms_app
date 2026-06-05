import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'dart:developer';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FirebaseMessaging messaging = FirebaseMessaging.instance;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    // Permission
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    log("Permission: ${settings.authorizationStatus}");

    // Token
    String? token = await messaging.getToken();

    log("FCM TOKEN: $token");

    // Local notification init
    const AndroidInitializationSettings androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settingsInit = InitializationSettings(
      android: androidSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(settingsInit);

    FirebaseMessaging.onMessage.listen((message) {

      log("MESSAGE RECEIVED");
      log("DATA: ${message.data}");
      log("TITLE: ${message.notification?.title}");

      String type = message.data['type'] ?? "default";

      if (type == "chat") {

        showNotification(
          message,
          "mixkit_little_bird_calling_chirp_23",
        );

      } else if (type == "order") {

        showNotification(
          message,
          "mixkit_little_bird_calling_chirp_23",
        );

      } else {

        showNotification(
          message,
          "mixkit_little_bird_calling_chirp_23",
        );
      }
    });


    // Open app from notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log("Notification Clicked");
    });
  }

  Future<void> showNotification(
      RemoteMessage message,
      String soundName,
      ) async {

    AndroidNotificationChannel channel = AndroidNotificationChannel(
      soundName,
      soundName,
      importance: Importance.max,
      playSound: true,
      sound: RawResourceAndroidNotificationSound(soundName),
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    AndroidNotificationDetails androidDetails =
    AndroidNotificationDetails(
      channel.id,
      channel.name,
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      sound: RawResourceAndroidNotificationSound(soundName),
    );

    NotificationDetails details =
    NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      message.notification?.title ?? message.data['title'],
      message.notification?.body ?? message.data['body'],
      details,
    );
  }

}

@pragma('vm:entry-point')
Future<void> firebaseBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  log("Background Message: ${message.messageId}");
}


