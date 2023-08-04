import 'package:flutter/material.dart';

class UI1 extends StatefulWidget {
  const UI1({Key? key}) : super(key: key);

  @override
  State<UI1> createState() => _UI1State();
}

class _UI1State extends State<UI1> {
  Color color = Colors.green;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Stack(
              children: [
                Container(
                  height: 350,
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(40))),
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          'assets/img/river pollution.jpg',
                          height: 80,
                          fit: BoxFit.cover,
                          width: 80,
                        ),
                      ),
                      Text("Your Profile Name"),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 100.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: const LinearProgressIndicator(
                            value: .7,
                            minHeight: 10,
                            color: Colors.green,
                            backgroundColor: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  height: 150,
                  decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(40))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Profile",
                        style: TextStyle(fontSize: 28, color: Colors.white),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.search,
                            size: 34,
                            color: Colors.white,
                          ))
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onVerticalDragUpdate: (details) {
                // print(details);
                if (details.delta.dy > 0.1) {
                  setState(() {
                    color = Colors.red;
                  });
                } else if (details.delta.dy < -0.1) {
                  setState(() {
                    color = Colors.green;
                  });
                }
              },
              onVerticalDragStart: (details) {
                print(details.globalPosition.dx);
                if (details.globalPosition.dx < 160) {
                  setState(() {
                    color = Colors.purpleAccent;
                  });
                }
              },
              onHorizontalDragUpdate: (details) {
                // print(details);
                if (details.delta.dx > 0.3) {
                  setState(() {
                    color = Colors.pink;
                  });
                } else if (details.delta.dx < -0.3) {
                  setState(() {
                    color = Colors.lightBlue;
                  });
                }
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                height: 250,
                color: color,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Stack(
              children: [
                Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * .4,
                      color: Colors.black,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * .4,
                    )
                  ],
                ),
                Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 4,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        "Explore\nthe world",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * .65,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return RotatedBox(
                              quarterTurns: 3,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text("data"),
                                    SizedBox(
                                      width: 100,
                                    ),
                                    Text("data"),
                                    SizedBox(
                                      width: 100,
                                    ),
                                    Text(
                                      "data",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    )
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return Container(
                              margin: EdgeInsets.only(right: 20),
                              width: 200,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.red,
                              ),
                            );
                          }
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
