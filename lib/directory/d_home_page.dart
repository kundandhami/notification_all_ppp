import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notification_all_ppp/directory/sms_autofill.dart';
import 'package:notification_all_ppp/practice_all.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DHomePage extends StatefulWidget {
  const DHomePage({Key? key}) : super(key: key);

  @override
  State<DHomePage> createState() => _DHomePageState();
}

class _DHomePageState extends State<DHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController =
      AnimationController(vsync: this, duration: Duration(seconds: 10))
        ..repeat(reverse: false);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 243, 243, 1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Icon(
          Icons.menu_rounded,
          color: Colors.black87,
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, RotatedBoxs(child: AutoFill()));
              },
              icon: Icon(
                Icons.send,
                color: Colors.black87,
              ))
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(20),
                    ),
                    color: Colors.white),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),

                      /*  RotationTransition(
                        turns: Tween<double>(begin: 0, end: 4)
                            .animate(animationController),
                        child: Container(
                          height: 300,
                          width: 300,
                          decoration: BoxDecoration(
                              // shape: BoxShape.circle,
                              gradient: SweepGradient(
                                  center: FractionalOffset.center,
                                  colors: [
                                Colors.transparent,
                                Color(0xff34a853),
                                Colors.transparent
                              ],
                                  stops: [
                                .2,
                                .25,
                                .2
                              ])),
                        ),
                      ),
                      RotationTransition(
                        turns: Tween<double>(begin: 0, end: 4)
                            .animate(animationController),
                        child: Container(
                          height: 300,
                          width: 300,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: RadialGradient(
                                focalRadius: 10,
                                radius: 1,
                                tileMode: TileMode.clamp,
                                colors: [
                                  Colors.red,
                                  Colors.black,
                                  Colors.blueGrey,
                                  Color(0xff34a853),
                                  Colors.black,
                                ],
                              )),
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            RotationTransition(
                              turns: Tween<double>(begin: 0, end: 100)
                                  .animate(animationController),
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: SweepGradient(
                                    colors: [
                                      Colors.blue,
                                      Colors.transparent,
                                      Colors.green,
                                      Colors.transparent,
                                      Colors.red,
                                      Colors.amberAccent,
                                      Colors.pink,
                                      Colors.greenAccent
                                    ], // Customize the gradient colors here
                                  ),
                                ),
                                child: Container(
                                  margin: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black87),
                                ),
                              ),
                            ),
                            Text(
                              "  Loading",
                              style: TextStyle(fontSize: 20, color: Colors.white),
                            )
                          ],
                        ),
                      ),*/

                      Text(
                        "Find Your",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Inspiration",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 22),
                      ),
                      SizedBox(height: 15),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey.shade500),
                        child: TextField(
                          onTapOutside: (v) {
                            FocusScope.of(context).unfocus();
                          },
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.search),
                              hintText: "Search you're looking for",
                              hintStyle: TextStyle(color: Colors.black38),
                              border: InputBorder.none),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      )
                    ]),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  "Promo Today",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  children: [
                    Promocard(
                      imageUrl:
                          'https://images-eu.ssl-images-amazon.com/images/G/31/img2021/Vday/bwl/English.jpg',
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Promocard(
                      imageUrl:
                          'https://images-na.ssl-images-amazon.com/images/G/31/Symbol/2020/00NEW/1242_450Banners/PL31_copy._CB432483346_.jpg',
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    "https://plus.unsplash.com/premium_photo-1675979807697-24195c443a7f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=503&q=80",
                    height: 150,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 4)
                          ]),
                      height: 120,
                      margin: EdgeInsets.only(top: 20),
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      alignment: Alignment.centerLeft,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "NEW TREND",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    Image.asset(
                      "assets/new_trend.png",
                      height: 140,
                      width: 120,
                    )
                  ],
                ),
              ),
              GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    childAspectRatio: .95),
                physics: const NeverScrollableScrollPhysics(),
                itemCount: listArr.length,
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemBuilder: (context, index) {
                  var pObj = listArr[index];
                  return Stack(alignment: Alignment.topRight, children: [
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(color: Colors.black12, blurRadius: 4)
                          ]),
                      alignment: Alignment.bottomLeft,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            pObj["name"].toString(),
                            style: TextStyle(
                                color: Colors.brown,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            pObj["detail"],
                            style: TextStyle(
                                color: Colors.brown.shade500, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Image.asset(
                        pObj["image"],
                        height: 100,
                      ),
                    )
                  ]);
                },
              ),
              SizedBox(
                height: 20,
              ),
              ProduckShow(obj: saveArr[0]),
              ProduckShow(obj: saveArr[1]),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  List saveArr = [
    {"name": "Handbag LV", "price": "\$225", "image": "assets/handbag.png"},
    {"name": "T-shirt", "price": "\$123", "image": "assets/t-shirt.png"},
  ];
  List listArr = [
    {
      "name": "Graphic shirts",
      "detail": "The fine print",
      "image": "assets/graphic_shirts.png",
    },
    {
      "name": "Summer co-ords",
      "detail": "Just add kicks",
      "image": "assets/summer_co_ords.png"
    },
    {
      "name": "Sandals",
      "detail": "Stay cool",
      "image": "assets/sandal.png",
    },
    {
      "name": "Face coverings",
      "detail": "Washable",
      "image": "assets/face_coverings.png"
    }
  ];
}

class Promocard extends StatelessWidget {
  final String imageUrl;
  final double height;
  const Promocard({Key? key, required this.imageUrl, this.height = 230})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          height: height,
        ),
      ),
    );
  }
}

class ProduckShow extends StatelessWidget {
  Map obj;
  ProduckShow({Key? key, required this.obj}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          Container(
            margin: EdgeInsets.only(left: 50, top: 30, right: 20),
            padding: EdgeInsets.only(left: 55, top: 15, bottom: 15, right: 15),
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
              )
            ], color: Colors.white),
            alignment: Alignment.bottomLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  obj['name'],
                  style: TextStyle(fontSize: 18, color: Colors.black12),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(obj['price']),
                    Container(
                      padding: EdgeInsets.all(3),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 15,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Image.asset(
              obj['image'],
              height: 80,
            ),
          )
        ],
      ),
    );
  }
}
