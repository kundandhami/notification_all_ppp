import 'dart:async';

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:flutter/services.dart';

class HomePages extends StatefulWidget {
  const HomePages({Key? key}) : super(key: key);

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> animation;
  late Animation<double> sizeAnimation;
  late Animation<Offset> offsetAnimation;
  bool isData = false;

  late IO.Socket soceket;
  late final AnimationController newAnimationController =
      AnimationController(vsync: this, duration: Duration(seconds: 3))
        ..forward();
  late Animation<double> newAnimation = CurvedAnimation(
      parent: newAnimationController, curve: Curves.easeInCubic);

  void connect() {
    print("Socket--io");
    soceket = IO.io("http://192.168.29.187:2000", <String, dynamic>{
      "transport": ['websocket'],
      "autoConnect": false,
    });
    soceket.connect();
    soceket.onConnect((data) => print("Connected"));
    print(soceket.connected);
    soceket.emit("/test", "hello world");
  }

  bool _forward = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    connect();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 10))
          ..forward()
          ..addStatusListener((status) {
            print("hey-------${status}");
            if (status == AnimationStatus.completed) {
              print("start");
              if (_forward) {
                print("here1");
                animationController.reverse();
              } else {
                print("here2");

                animationController.forward();
              }
              _forward = !_forward;
            }
          });
    animation = Tween<Offset>(
      begin: Offset(0, 0),
      end: Offset(1, 5),
    ).animate(
        CurvedAnimation(parent: animationController, curve: Curves.linear));

    sizeAnimation = Tween<double>(begin: 40, end: 180).animate(
        CurvedAnimation(parent: animationController, curve: Curves.bounceIn));
    offsetAnimation = Tween(begin: Offset(0, 0), end: Offset(0, 1)).animate(
        CurvedAnimation(parent: animationController, curve: Curves.bounceIn));
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: Text("data "),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SlideTransition(
                position: animation,
                child: FlutterLogo(
                  size: 40,
                ),
              ),
              SizedBox(
                height: 500,
                child: SlideTransition(
                  position: offsetAnimation,
                  child: Row(
                    children: List.generate(
                        4,
                        (index) => Flexible(
                              child: Icon(
                                Icons.camera,
                                size: sizeAnimation.value,
                              ),
                            )),
                  ),
                ),
              ),
              FadeTransition(
                opacity: newAnimation,
                child: Text(
                  "New App",
                  style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          "assets/fashion.jpeg",
                          height: 200,
                          width: 150,
                          fit: BoxFit.cover,
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Main Category",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "\$ 100",
                      style: TextStyle(),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                  child: Image.asset(
                    "assets/essentials.jpeg",
                    height: 200,
                    width: 150,
                    fit: BoxFit.cover,
                  )),
              Container(
                padding: EdgeInsets.only(left: 10),
                width: 150,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Main Category",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "\$ 100",
                      style: TextStyle(),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 200,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class slideTransiton extends ChangeNotifier {}

class CustomPageRoute extends PageRouteBuilder {
  final Widget child;
  CustomPageRoute({required this.child})
      : super(
            transitionDuration: Duration(seconds: 1),
            pageBuilder: (context, animation, secoundaryanimation) => child);

  @override
  Widget BuildTransition(BuildContext context, Animation<double> animation,
      Animation<double> secoundryanimation, Widget child) {
    return SlideTransition(
        position: Tween<Offset>(begin: Offset(-1, 0), end: Offset.zero)
            .animate(animation),
        child: child);
  }
}
