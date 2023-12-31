import 'dart:async';
import 'package:async/async.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:notification_all_ppp/directory/animation/flip_page.dart';
import 'package:notification_all_ppp/directory/d_3.dart';
import 'package:notification_all_ppp/directory/d_4_serch.dart';
import 'package:notification_all_ppp/directory/google_ad/google_ad.dart';
import 'package:notification_all_ppp/directory/nested_custome_scroller_view.dart';
import 'package:notification_all_ppp/directory/riverpod/r_1.dart';
import 'package:notification_all_ppp/directory/wall_paper/w_home_page.dart';
import 'package:notification_all_ppp/practice_all.dart';
import 'package:notification_all_ppp/service/notification_controller.dart';
import 'package:notification_all_ppp/src/screen/homepage.dart';
import 'package:notification_all_ppp/src/screen/mongo_db_service.dart';
import 'package:notification_all_ppp/view/firebase_messaging_local_notification/notification_service.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart' as provider;
import 'package:quick_actions/quick_actions.dart';
import 'directory/animation/bottom_sheet.dart';
import 'directory/animation/image_size_change.dart';
import 'directory/animation/starch_burg.dart';
import 'directory/d_home_page.dart';
import 'directory/downloader/downloader.dart';
import 'directory/firebase_all/auth_authentication.dart';
import 'directory/payment.dart';
import 'directory/search_datas/search_data_all_types.dart';
import 'directory/sms_autofill.dart';
import 'directory/ui/UI_1.dart';
import 'package:notification_all_ppp/directory/search_datas/provider_datas.dart';

Future<void> backgroundhendler(RemoteMessage message) async {
  debugPrint("background firebase message on+++");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  ///local_notification
  await Firebase.initializeApp();
  Notificationss().requstnotification();
  final token = await Notificationss().gettoken();
  print("token-----$token");
  FirebaseMessaging.onBackgroundMessage(backgroundhendler);

  ///awesome notification
  await NotificationController.initializationNotification();
  await NotificationController.initializationNotificationListener();
  await NotificationController.initializationRemoteNotification();
  scheduleMicrotask(() async {
    await NotificationController.getInitialNotificationAction();
  });

  runApp(ProviderScope(
      child: MultiProvider(providers: [
    provider.ChangeNotifierProvider(create: (_) => ProviderData()),
    provider.ChangeNotifierProvider(create: (_) => ProviderDataCity()),
  ], child: const MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    Notificationss().firebasemessagebackground(context);
    Notificationss().firebasemessaging(context);
    return MaterialApp(
        scaffoldMessengerKey: scaffoldState,
        navigatorKey: MyApp.navigatorKey,
        home: const Authentication_firebase()
        // SplaceScreen(),
        );
  }
}

final GlobalKey<ScaffoldMessengerState> scaffoldState =
    GlobalKey<ScaffoldMessengerState>();

class MobileAd extends StatefulWidget {
  const MobileAd({Key? key}) : super(key: key);

  @override
  State<MobileAd> createState() => _MobileAdState();
}

class _MobileAdState extends State<MobileAd> {
  final quickAction = QuickActions();
  @override
  void initState() {
    super.initState();
    quickAction.setShortcutItems([
      const ShortcutItem(
          type: 'googleAD', localizedTitle: 'Google AD', icon: 'icon_main'),
      const ShortcutItem(
          type: 'download', localizedTitle: 'Download', icon: 'icon_help'),
      const ShortcutItem(type: "dHomePage", localizedTitle: "DHomePage"),
      const ShortcutItem(
          type: "PaymentIntegration", localizedTitle: "PaymentIntegration")
    ]);
    quickAction.initialize((shortcutType) {
      if (shortcutType == 'googleAD') {
        print('The user tapped on the "Main view" action.');
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GoogleAd(),
            ));
      } else if (shortcutType == 'download') {
        print('The user tapped on the "Main view" action.');
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Downloader(),
            ));
      } else if (shortcutType == 'PaymentIntegration') {
        print('The user tapped on the "Main view" action.');
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PaymentIntegration(),
            ));
      } else if (shortcutType == 'dHomePage') {
        print('The user tapped on the "Main view" action.');
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DHomePage(),
            ));
      }
      // More handling code...
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          RichText(
              text: TextSpan(
                  text: "data",
                  recognizer: TapGestureRecognizer()..onTap = () {}))
        ],
      ),
    );
  }
}
