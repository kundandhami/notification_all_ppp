import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/material.dart';

class BottomSheets extends StatefulWidget {
  const BottomSheets({Key? key}) : super(key: key);

  @override
  State<BottomSheets> createState() => _BottomSheetsState();
}

class _BottomSheetsState extends State<BottomSheets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Container(
              height: 40,
            ),
            BottomSheetTransforn()
          ],
        ),
      ),
    );
  }
}

class BottomSheetTransforn extends StatefulWidget {
  const BottomSheetTransforn({Key? key}) : super(key: key);

  @override
  State<BottomSheetTransforn> createState() => _BottomSheetTransfornState();
}

class _BottomSheetTransfornState extends State<BottomSheetTransforn>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  double get totalSize => MediaQuery.of(context).size.height - 40;
  double startheight = 45;
  double endtheight = 120;

  double horizontalSpaceing = 15;
  double verticalSpaceing = 25;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Positioned(
            left: 0,
            bottom: 0,
            right: 0,
            top: lerpDouble(120, totalSize, controller.value),
            child: GestureDetector(
              onTap: () {
                final bool isCompleted =
                    controller.status == AnimationStatus.completed;
                controller.fling(velocity: isCompleted ? -1 : 1);
              },
              onVerticalDragUpdate: (DragUpdateDetails ca) {
                controller.value -= ca.primaryDelta! / totalSize;
              },
              onVerticalDragEnd: (va) {
                if (controller.isAnimating ||
                    controller.status == AnimationStatus.completed) {
                  return;
                }
                final double filingvelocity =
                    va.velocity.pixelsPerSecond.dy / totalSize;
                if (filingvelocity < 0) {
                  controller.fling(velocity: math.max(1, -filingvelocity));
                } else if (filingvelocity > 0) {
                  controller.fling(velocity: math.min(-1, -filingvelocity));
                } else {
                  controller.fling(velocity: controller.value < 0.5 ? -1 : 1);
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xff950201),
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20))),
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Stack(
                  children: [
                    Positioned(
                        left: 0,
                        right: 0,
                        top: lerpDouble(20, 40, controller.value),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Song",
                              style: TextStyle(color: Colors.white),
                            ),
                            Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            )
                          ],
                        )),
                    Positioned(
                        top: lerpDouble(35, 80, controller.value),
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: SingleChildScrollView(
                          scrollDirection:
                              controller.status == AnimationStatus.completed
                                  ? Axis.vertical
                                  : Axis.horizontal,
                          physics: BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          child: Container(
                            height:
                                (endtheight + verticalSpaceing) * songs.length,
                            width: (startheight + horizontalSpaceing) *
                                songs.length,
                            child: Stack(
                              children: [
                                for (String song in songs) buildContainers(song)
                              ],
                            ),
                          ),
                        ))
                  ],
                ),
              ),
            ));
      },
    );
  }

  List songs = [
    "assets/img/Border collie plays with a blond 7-years-old girl .jpg",
    "assets/img/I walk the streets of this sweltering city.jpg",
    "assets/img/M light.jpg",
    "assets/img/M light (1).jpg",
    "assets/img/mountain with forest.jpg",
    "assets/img/naturaleza deporte ardilla.jpg",
    "assets/img/river pollution.jpg",
    "assets/img/Vintage anime screenshot from Akira.jpg",
    "assets/img/vulcão cuspindo gelo.jpg",
    "assets/img/vulcão cuspindo gelo (1).jpg",
    "assets/img/river pollution.jpg",
  ];
  Widget buildContainers(String song) {
    int index = songs.indexOf(song);
    return Container();
  }
}
