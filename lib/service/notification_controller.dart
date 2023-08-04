import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:awesome_notifications_fcm/awesome_notifications_fcm.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notification_all_ppp/main.dart';
import 'package:notification_all_ppp/service/local_notification.dart';
import 'package:notification_all_ppp/view/splace_screen.dart';

class NotificationController extends ChangeNotifier {
  // SINGLETON  PATTERN
  static final NotificationController _instance =
      NotificationController._internal();

  factory NotificationController() {
    return _instance;
  }

  NotificationController._internal();

  ///REMOTE NOTIFICATION INITILAZITION

  static Future<void> initializationRemoteNotification() async {
    await Firebase.initializeApp();
    await AwesomeNotificationsFcm().initialize(
        onFcmSilentDataHandle: onFcmSilentDataHandle,
        onFcmTokenHandle: onFcmTokenHandle,
        onNativeTokenHandle: onNativeTokenHandle,
        licenseKeys: [],
        debug: true);
  }

  static Future<void> onFcmSilentDataHandle(FcmSilentData fcmSilentData) async {
    debugPrint("onFcmSilentDataHandle--${fcmSilentData}");

    if (fcmSilentData.data!['islivescore'] == "true") {
      NotificationController.silentNotificationShow(
          id: 1,
          title: fcmSilentData.data!['title']!,
          body: fcmSilentData.data!['body']!,
          largeIcon: fcmSilentData.data!['largeIcon']);
    }

    if (fcmSilentData.createdLifeCycle == NotificationLifeCycle.Foreground) {
      print("APP IS FORGROUND___");
    } else {
      print("APP IS BACKGROUND");
    }
  }

  static Future<void> onFcmTokenHandle(String token) async {
    debugPrint("onFcmTokenHandle--$token");
  }

  static Future<void> onNativeTokenHandle(String token) async {
    debugPrint("onNativeTokenHandle--$token");
  }

  static Future<String> requestToken() async {
    if (await AwesomeNotificationsFcm().isFirebaseAvailable) {
      try {
        return await AwesomeNotificationsFcm().requestFirebaseAppToken();
      } catch (ex) {
        debugPrint(ex.toString());
      }
    } else {
      debugPrint("firebase not available in this project");
    }
    return "";
  }

  ///subscribe or unsubscribe topic
  static Future<void> subscribeTopic(String topic) async {
    await AwesomeNotificationsFcm().subscribeToTopic(topic);
  }

  static Future<void> unSubscribeTopic(String topic) async {
    await AwesomeNotificationsFcm().unsubscribeToTopic(topic);
  }

  /// INITIALIZATION METHOD

  static Future<void> initializationNotification() async {
    await AwesomeNotifications().initialize(
        null,
        [
          NotificationChannel(
            channelKey: "basic_channel",
            channelName: "Basic notifications",
            channelDescription: "Notification channel for basic tests",
            importance: NotificationImportance.High,
            // icon: "resource://drawable/res_naruto",
            // playSound: true,
            // soundSource: "resource://raw/naruto_jutsu",
          ),
          NotificationChannel(
              channelGroupKey: "chat_tests",
              channelKey: "chats",
              channelName: "Group chats",
              channelDescription: "This is a simple chat group",
              channelShowBadge: true,
              importance: NotificationImportance.Max)
        ],
        debug: true);
  }

  //EVENT Listner

  static Future<void> initializationNotificationListener() async {
    await AwesomeNotifications().setListeners(
        onActionReceivedMethod: NotificationController.onActionReceivedMethod,
        onNotificationCreatedMethod:
            NotificationController.onNotificationCreatedMethod,
        onNotificationDisplayedMethod:
            NotificationController.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod:
            NotificationController.onDismissActionReceivedMethod);
  }

  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    print(receivedAction.toString());
    if (receivedAction.channelKey == "chats") {
      receiveChatNotificationAction(receivedAction);
    }
    if (receivedAction.channelKey == "basic_channel") {
      NotificationController.navigatorHelper(receivedAction);
    }
  }

  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint("onNotificationCreatedMethod");
  }

  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint("onNotificationDisplayedMethod");
  }

  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    debugPrint("onDismissActionReceivedMethod");
  }

  static navigatorHelper(ReceivedAction receivedAction) {
    if (receivedAction.payload != null &&
        receivedAction.payload!['ScreenName'] == "tap_Screen") {
      MyApp.navigatorKey.currentState!.push(MaterialPageRoute(
        builder: (context) => SplaceScreen(),
      ));
    }
  }

  ///when app is kill state
  static Future<void> getInitialNotificationAction() async {
    ReceivedAction? receivedAction = await AwesomeNotifications()
        .getInitialNotificationAction(removeFromActionEvents: true);
    if (receivedAction == null) return;
    navigatorHelper(receivedAction);
  }

  ///groupmessaging replay handle
  static Future<void> receiveChatNotificationAction(
      ReceivedAction receivedAction) async {
    if (receivedAction.buttonKeyPressed == "REPLY") {
      await LocalNotification.createMessagingNotification(
          channelKey: "chats",
          groupKey: receivedAction.groupKey!,
          chatName: receivedAction.summary!,
          userName: "you",
          message: receivedAction.buttonKeyInput,
          largeIcon:
              "https://wabuildmart.com/images/logo/2023/04/aff-logo.png-2023-04-12_17_38_57.png");
    } else {}
  }

// Live Score
  static Future<void> silentNotificationShow(
      {required int id,
      required String title,
      required String body,
      String? largeIcon}) async {
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: id,
            channelKey: "basic_channel",
            title: title,
            body: body,
            largeIcon: largeIcon,
            locked: false));
  }
}
