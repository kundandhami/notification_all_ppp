import 'dart:isolate';
import 'package:flutter/material.dart';
import 'dart:async';

class ShareScreen extends StatefulWidget {
  const ShareScreen({Key? key}) : super(key: key);

  @override
  State<ShareScreen> createState() => _ShareScreenState();
}

class _ShareScreenState extends State<ShareScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          CircularProgressIndicator(),
          RawMaterialButton(
            fillColor: Colors.orangeAccent,
            onPressed: () {
              for (int i = 0; i < 100000000000; i++) {
                print(i);
              }
            },
            child: Text("Heavy Task"),
          ),
          CircularProgressIndicator(),
          RawMaterialButton(
            fillColor: Colors.orangeAccent,
            onPressed: () {
              isoLateFunction();
            },
            child: Text("Heavy Task"),
          ),
        ],
      ),
    );
  }

  isoLateFunction() async {
    final ReceivePort receivePort = ReceivePort();
    try {
      await Isolate.spawn(runTask, [receivePort.sendPort, 99999999999999]);
    } catch (e) {
      print("isolate eror $e");
      receivePort.close();
    }
    final response = await receivePort.first;
    print("data===$response");
  }

  int runTask(List<dynamic> args) {
    SendPort sendPort = args[0];
    int value = 0;
    for (int i = 0; i < args[1]; i++) value++;

    Isolate.exit(sendPort, value);
  }
}
