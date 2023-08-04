import 'dart:math';
import 'package:awesome_notifications/awesome_notifications.dart';

int createUniqueID(int maxvalue) {
  Random random = Random();
  return random.nextInt(maxvalue);
}

class LocalNotification {
  static sedulNotification() {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 1,
          channelKey: "basic_channel",
          title: "Schedule notification",
          body: "Body Schedule",
          bigPicture:
              "https://wabuildmart.com/images/logo/2023/04/aff-logo.png-2023-04-12_17_38_57.png",
          notificationLayout: NotificationLayout.BigPicture,
        ),
        /* schedule: NotificationCalendar.fromDate(
            date: DateTime.now().add(Duration(seconds: 15)),
            preciseAlarm: true,
            allowWhileIdle: true,
            repeats: true)*/
        schedule: NotificationCalendar(
          second: 1,
          repeats: true,
        ));
  }

  static Future<void> cancelScheduleNotification(int id) async {
    await AwesomeNotifications().cancelSchedule(id);
  }

  static showNotificationWithActionButton({required int id}) {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: id,
            channelKey: "basic_channel",
            title: "Action",
            body: "Body Action Button"),
        actionButtons: [
          NotificationActionButton(
            key: "SUBSCRIBE",
            label: "Scbscribe",
            autoDismissible: true,
          ),
          NotificationActionButton(
              key: "DISMISS", label: "send", autoDismissible: true),
        ]);
  }

  static Future<void> createNotificationWithPlayload() async {
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 111,
            channelKey: "basic_channel",
            title: "Notification All Time Receive",
            body: "Navigate to Screen",
            payload: {"ScreenName": "tap_Screen"}));
  }

  //CHAT NOTIFICATION
  static Future<void> createMessagingNotification(
      {required String channelKey,
      required String groupKey,
      required String chatName,
      required String userName,
      required String message,
      String? largeIcon}) async {
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: createUniqueID(AwesomeNotifications.maxID),
            groupKey: groupKey,
            channelKey: channelKey,
            summary: chatName,
            title: userName,
            body: message,
            largeIcon: largeIcon,
            notificationLayout: NotificationLayout.MessagingGroup,
            category: NotificationCategory.Message),
        actionButtons: [
          NotificationActionButton(
              key: "REPLY",
              label: "Replay",
              requireInputText: true,
              autoDismissible: false),
          NotificationActionButton(
              key: "READ", label: "Mark as Read", autoDismissible: true),
        ]);
  }

  ///progress notification
  static Future<void> creatProgressNotification() async {
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 23,
            channelKey: "basic_channel",
            title: "Downloading file...",
            body: "filename.txt",
            category: NotificationCategory.Progress,
            payload: {"file": "filename.txt"},
            notificationLayout: NotificationLayout.ProgressBar,
            progress: null,
            locked: true));
    await Future.delayed(Duration(seconds: 5));
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 23,
            channelKey: "basic_channel",
            title: "File Download",
            body: "filename.txt",
            category: NotificationCategory.Progress,
            locked: false));
  }

  static int currentStep = 0;
  static Future<void> showProgressNotification(int id) async {
    int maxStep = 10;
    for (int i = 1; i <= maxStep + 1; i++) {
      currentStep = i;
      await Future.delayed(Duration(seconds: 1));
      _updateProgressBar(id: id, maxsttep: maxStep, step: currentStep);
    }
  }

  static Future<void> _updateProgressBar(
      {required int id, required int step, required int maxsttep}) async {
    if (step > maxsttep) {
      await AwesomeNotifications().createNotification(
          content: NotificationContent(
              id: id,
              channelKey: "basic_channel",
              title: "File Download",
              body: "filename.txt",
              category: NotificationCategory.Progress,
              locked: false));
    } else {
      int progrss = min((step / maxsttep * 100).round(), 100);
      await AwesomeNotifications().createNotification(
          content: NotificationContent(
        id: id,
        channelKey: "basic_channel",
        title: "Download file in Progress ($progrss)",
        body: "filename.txt",
        category: NotificationCategory.Progress,
        notificationLayout: NotificationLayout.ProgressBar,
        progress: progrss,
        locked: true,
      ));
    }
  }

  static Future<void> emojiNotification(int id) async {
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
      id: id,
      channelKey: "basic_channel",
      category: NotificationCategory.Social,
      title: "Emoji are show 😾😠🙈🙉🙊--${Emojis.smile_angry_face_with_horns}",
      body: "Emoji Here",
    ));
  }

  static Future<void> wakeUpNotification(int id) async {
    await Future.delayed(Duration(seconds: 5));
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
      id: id,
      channelKey: "basic_channel",
      title: "Wake Up ",
      body: "Hey Wake Up You Lazzy basterd..",
      wakeUpScreen: true,
    ));
  }
}
