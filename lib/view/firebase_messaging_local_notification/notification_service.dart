import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notification_all_ppp/view/firebase_messaging_local_notification/redirect_screen.dart';

///application tag ni upper
////
/*
<meta-data
android:name="com.google.firebase.messaging.default_notification_channel_id"
android:value="default_notification_channel_id" />
*/

///activity ni under
///
/*
<meta-data
                android:name="com.google.firebase.messaging.default_notification_channel_id"
                android:value="123" />
            <intent-filter>
                <action android:name="FLUTTER_NOTIFICATION_CLICK" />
                <category android:name="android.intent.category.DEFAULT" />
            </intent-filter>

            <intent-filter>
                <action android:name="com.google.firebase.MESSAGING_EVENT" />
            </intent-filter>
            */
///app-build.gradle
/*
last ma
apply plugin: 'com.google.gms.google-services'

///dependecies
implementation platform('com.google.firebase:firebase-bom:32.1.1')
*/
///buildgradle
/*
//dependency
classpath 'com.google.gms:google-services:4.3.15'
*/

class Notificationss {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();

  void localnotificationinintal(RemoteMessage message, BuildContext context) {
    /* print("111localnotification initalise");
    AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("@mipmap/ic_launcher");
    DarwinInitializationSettings ios = DarwinInitializationSettings();
    InitializationSettings initializationSettings = InitializationSettings(
        android: androidInitializationSettings, iOS: ios);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (plyload) {
      handlemessage(message, context);
    });*/
  }

  void handlemessage(RemoteMessage message, BuildContext context) {
    print("111===here message handle===>${message.notification?.title}");

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RedirectScreen(message: message),
        ));
  }

  Future<void> notificationshow(RemoteMessage message) async {
    /* print("111notification show");
    AndroidNotificationDetails android = AndroidNotificationDetails(
      // Random.secure().nextInt(10000).toString(),
      "123",
      "channelName",
      channelDescription: "High importance",
      priority: Priority.high,
      importance: Importance.max,
    );
    DarwinNotificationDetails ios = DarwinNotificationDetails(
        presentAlert: true, presentBadge: true, presentSound: true);
    NotificationDetails notificationDetails =
        NotificationDetails(android: android, iOS: ios);

    final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    await flutterLocalNotificationsPlugin.show(
        id,
        // Random.secure().nextInt(1000),
        message.notification?.title,
        message.notification?.body,
        notificationDetails);*/
  }

  ///all are initialize in void main respectevely
  void firebasemessaging(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) {
      print("111onMessage+++++++++");
      localnotificationinintal(message, context);
      notificationshow(message);
      // showTimerNotification(message);
    });
  }

  Future<void> firebasemessagebackground(BuildContext context) async {
    RemoteMessage? message = await messaging.getInitialMessage();

    if (message != null) {
      print("111bg======");
      handlemessage(message, context);
    }

    FirebaseMessaging.onMessageOpenedApp.listen((messages) {
      print("111onMessageOpenedApp+++++++++");

      // localnotificationinintal(messages, context);
      handlemessage(messages, context);
    });
  }

  Future<String?> gettoken() async {
    return await messaging.getToken();
  }

  Future<void> requstnotification() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            badge: true, sound: true, alert: true);

    NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: true,
        sound: true,
        provisional: true);
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("user give permission");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print("user give provisional");
    } else {
      print("user give denied");
      // AppSettings.openNotificationSettings(callback: () {});
    }
  }
}
