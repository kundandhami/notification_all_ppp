import 'package:flutter/material.dart';

class StarBurg extends StatefulWidget {
  const StarBurg({Key? key}) : super(key: key);

  @override
  State<StarBurg> createState() => _StarBurgState();
}

class _StarBurgState extends State<StarBurg> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 15).copyWith(top: 15),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Good\nMorning!",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.asset(
                    "assets/img/I walk the streets of this sweltering city.jpg",
                    height: 40,
                    width: 40,
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                "assets/img/river pollution.jpg",
                width: double.maxFinite,
                height: 180,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 120,
              child: ListView.builder(
                itemExtent: 80,
                scrollDirection: Axis.horizontal,
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          images[index],
                          fit: BoxFit.cover,
                          height: 80,
                          width: 60,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(names[index])
                    ],
                  );
                },
              ),
            ),
            SizedBox(
              height: 15,
            ),
            DefaultTabController(
                length: 6,
                child: TabBar(
                    indicatorColor: Colors.black87,
                    labelColor: Colors.white,
                    isScrollable: true,
                    unselectedLabelColor: Colors.blueGrey,
                    indicator: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                            bottom: Radius.circular(20))),
                    tabs: [
                      Tab(
                        text: "Coffees",
                      ),
                      Tab(
                        text: "Tea",
                      ),
                      Tab(
                        text: "Drink",
                      ),
                      Tab(
                        text: "Soft",
                      ),
                      Tab(
                        text: "Food",
                      ),
                      Tab(
                        text: "Chips",
                      ),
                    ])),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 300,
              child: PageView.builder(
                scrollDirection: Axis.horizontal,
                controller: PageController(viewportFraction: .7),
                onPageChanged: (v) {
                  setState(() {
                    indexs = v;
                  });
                },
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return Transform.scale(
                    scale: index == indexs ? 1 : .9,
                    child: Container(
                      height: 200,
                      width: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: index == indexs ? Colors.green : Colors.red,
                      ),
                      child: Center(
                          child: Image.asset(
                        images[index],
                        height: 150,
                        width: 150,
                      )),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

int indexs = 0;

List names = [
  "Coffes",
  "Tea",
  'Chai',
  'Ice',
  "Creame",
  "Heam Cream",
  "Cold",
  "Hot",
  "Chill",
  "It's Ok",
  "Ready Bro"
];

List images = [
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
  "assets/img/street/cyber punk (1).jpg",
];
