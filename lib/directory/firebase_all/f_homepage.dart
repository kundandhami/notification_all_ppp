import 'package:flutter/material.dart';
import 'package:notification_all_ppp/directory/firebase_all/database.dart';

class FHomePage extends StatefulWidget {
  const FHomePage({Key? key}) : super(key: key);

  @override
  State<FHomePage> createState() => _FHomePageState();
}

class _FHomePageState extends State<FHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseDB.firebaseAuth.signOut();
                await FirebaseDB.googleSignIn.signOut();
                setState(() {});
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Column(
        children: [
          Text(FirebaseDB.firebaseAuth.currentUser?.email.toString() ?? "")
        ],
      ),
    );
  }
}
