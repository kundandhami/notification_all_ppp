import 'package:flutter/material.dart';

class ImageSizeChange extends StatefulWidget {
  const ImageSizeChange({Key? key}) : super(key: key);

  @override
  State<ImageSizeChange> createState() => _ImageSizeChangeState();
}

class _ImageSizeChangeState extends State<ImageSizeChange> {
  double height = 70;
  double width = 200;
  bool click = true;
  Offset offset = Offset.zero;

  //for zoom
  final transController = TransformationController();
  TapDownDetails? doubleTapDetails;
  handleDoubleTapDown(TapDownDetails details) {
    doubleTapDetails = details;
  }

  handleDoubleTap() {
    if (transController.value != Matrix4.identity()) {
      transController.value = Matrix4.identity();
    } else {
      final position = doubleTapDetails?.localPosition;
      transController.value = Matrix4.identity()
        ..translate(-position!.dx, -position!.dy)
        ..scale(6.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(),
      body: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              VerticalDivider(
                color: Colors.white,
                thickness: 20,
              ),
              VerticalDivider(
                color: Colors.red,
                thickness: 60,
              ),
            ],
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  click = !click;
                  if (click) {
                    width = MediaQuery.of(context).size.width;
                    height = MediaQuery.of(context).size.height / 2;
                  } else {
                    width = 250;
                    height = 70;
                  }
                });
              },
              child: AnimatedContainer(
                height: height,
                width: width,
                duration: Duration(seconds: 2),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2)),
                child: Image.asset(
                  "assets/img/vulcão cuspindo gelo.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            left: offset.dx,
            top: offset.dy,
            child: GestureDetector(
              onPanUpdate: (va) {
                setState(() {
                  offset =
                      Offset(offset.dx + va.delta.dx, offset.dy + va.delta.dy);
                });
              },
              child: Container(
                height: 100,
                width: 250,
                child: Image.asset("assets/img/naturaleza deporte ardilla.jpg"),
              ),
            ),
          ),
          Positioned(
              bottom: 10,
              left: 10,
              child: GestureDetector(
                onDoubleTapDown: handleDoubleTapDown,
                onDoubleTap: handleDoubleTap,
                child: InteractiveViewer(
                  transformationController: transController,
                  child: Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset("assets/img/street/cyber punk (1).jpg"),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
