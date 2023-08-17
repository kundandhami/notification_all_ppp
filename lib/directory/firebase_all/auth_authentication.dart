import 'package:flutter/material.dart';
import 'package:notification_all_ppp/directory/firebase_all/database.dart';
import 'package:notification_all_ppp/directory/firebase_all/f_homepage.dart';
import 'dart:developer';

class Authentication_firebase extends StatefulWidget {
  const Authentication_firebase({Key? key}) : super(key: key);

  @override
  State<Authentication_firebase> createState() =>
      _Authentication_firebaseState();
}

class _Authentication_firebaseState extends State<Authentication_firebase> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final pinController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Authentication"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: emailController,
            ),
            TextField(
              controller: passwordController,
            ),
            ElevatedButton(
                onPressed: () async {
                  // await FirebaseDB.emailAndPassword(
                  //     email: emailController.text,
                  //     password: passwordController.text);
                  await FirebaseDB.emailAndPasswordCheck(
                      email: emailController.text,
                      password: passwordController.text);

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FHomePage(),
                      ));
                },
                child: Text("email and password")),
            ElevatedButton(
                onPressed: () async {
                  await FirebaseDB.googleLogIn();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FHomePage(),
                      ));
                },
                child: Text("Google Login")),
            ElevatedButton(
                onPressed: () {
                  FirebaseDB.anonymousAuth();
                },
                child: Text("AnnoymousAuth")),
            TextField(
              controller: phoneController,
            ),
            TextButton(
                onPressed: () async {
                  await FirebaseDB.phoneNumerAuth(phoneController.text);
                },
                child: Text("SendOtp")),
            TextField(
              controller: pinController,
            ),
            TextButton(
                onPressed: () async {
                  await FirebaseDB.verifiedOTP(pinController.text);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FHomePage(),
                      ));
                },
                child: Text("Verified"))
          ],
        ),
      ),
    );
  }
}
