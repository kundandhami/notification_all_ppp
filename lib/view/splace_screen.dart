import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:notification_all_ppp/service/notification_controller.dart';
import 'package:notification_all_ppp/view/home_screen.dart';
import 'package:notification_all_ppp/view/share_screen.dart';

class SplaceScreen extends StatefulWidget {
  const SplaceScreen({Key? key}) : super(key: key);

  @override
  State<SplaceScreen> createState() => _SplaceScreenState();
}

class _SplaceScreenState extends State<SplaceScreen> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    precacheImage(NetworkImage("url"), context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    // TODO: implement initState
    AwesomeNotifications().isNotificationAllowed().then((isAllow) {
      if (!isAllow) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    NotificationController.requestToken();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
          (route) => false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification"),
      ),
      body: Center(
        child: Text("Splace_Screen"),
      ),
    );
  }
}
