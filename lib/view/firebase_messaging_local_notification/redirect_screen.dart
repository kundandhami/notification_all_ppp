import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class RedirectScreen extends StatefulWidget {
  RemoteMessage message;
  RedirectScreen({Key? key, required this.message}) : super(key: key);

  @override
  State<RedirectScreen> createState() => _RedirectScreenState();
}

class _RedirectScreenState extends State<RedirectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [],
      ),
    );
  }
}
