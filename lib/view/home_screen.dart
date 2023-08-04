import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:notification_all_ppp/service/local_notification.dart';
import 'package:notification_all_ppp/service/notification_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: triggerNotification,
              child: Text("Trigger Notification"),
            ),
          ),
          ElevatedButton(
              onPressed: LocalNotification.sedulNotification,
              child: Text("Sedule notification")),
          ElevatedButton(
              onPressed: () {
                LocalNotification.cancelScheduleNotification(1);
              },
              child: Text("Sedule notification cancel")),
          ElevatedButton(
              onPressed: () {
                LocalNotification.showNotificationWithActionButton(id: 12);
              },
              child: Text("Action Button")),
          ElevatedButton(
              onPressed: LocalNotification.createNotificationWithPlayload,
              child: Text("Background and Navigate to screen  ")),
          ElevatedButton(
              onPressed: () => LocalNotification.createMessagingNotification(
                  channelKey: "chats",
                  groupKey: "Emma_group",
                  chatName: "Emma_Group",
                  userName: "kundan ",
                  message: "This is group message",
                  largeIcon: "asset://assets/google.png"),
              child: Text("group message")),
          ElevatedButton(
              onPressed: () {
                LocalNotification.creatProgressNotification();
              },
              child: Text("Progress Bar")),
          ElevatedButton(
              onPressed: () {
                LocalNotification.showProgressNotification(2222);
              },
              child: Text("Progress Bar Continuess Change")),
          ElevatedButton(
              onPressed: () {
                LocalNotification.emojiNotification(45);
              },
              child: Text("Emoji ")),
          ElevatedButton(
              onPressed: () {
                LocalNotification.wakeUpNotification(90);
              },
              child: Text("Wake Up -Close the Phone ")),
          ElevatedButton(
              onPressed: () {
                NotificationController.subscribeTopic("anime");
              },
              child: Text("Subscribe topic")),
          ElevatedButton(
              onPressed: () {
                NotificationController.unSubscribeTopic("anime");
              },
              child: Text("unscbscribe topic")),
        ],
      ),
    );
  }

  triggerNotification() {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: 10,
          channelKey: "basic_channel",
          title: "Simple Notifiation",
          body: " Body",
          bigPicture:
              "https://wabuildmart.com/images/logo/2023/04/aff-logo.png-2023-04-12_17_38_57.png",
          notificationLayout: NotificationLayout.BigPicture),
    );
  }
}
