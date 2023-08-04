import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class D2 extends StatefulWidget {
  const D2({Key? key}) : super(key: key);

  @override
  State<D2> createState() => _D2State();
}

class _D2State extends State<D2> {
  List<String> images = [
    "https://plus.unsplash.com/premium_photo-1675979807697-24195c443a7f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=503&q=80",
    "https://images.unsplash.com/photo-1472214103451-9374bd1c798e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=870&q=80",
    "https://images.unsplash.com/photo-1625472603517-1b0dc72846ab?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80",
    "https://images.unsplash.com/photo-1504731231146-c0f65dc6a950?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80"
  ];
  List text = [
    "India\nNational Park",
    "Dang\nForest Park",
    "Kaginarga\nNational Park",
    "Mrut\nNational Park"
  ];
  late PageController controller;
  int page = 0;
  @override
  void initState() {
    controller = PageController(initialPage: 0);
    controller.addListener(() {
      page = controller.page?.round() ?? 0;
      print(page);
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: controller,
            itemCount: 4,
            itemBuilder: (context, index) {
              return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Image.network(
                      images[index],
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.center,
                              end: Alignment.bottomCenter,
                              colors: [
                            Colors.transparent,
                            Colors.black87.withOpacity(.6),
                            Colors.black87.withOpacity(.8),
                          ])),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FadeInLeft(
                            duration: Duration(milliseconds: 400),
                            child: Text(
                              text[index],
                              style:
                                  TextStyle(fontSize: 32, color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          FadeInLeft(
                            duration: Duration(milliseconds: 450),
                            child: Row(
                              children: [
                                Text(
                                  "🌟🌟🌟🌟🌟🌟",
                                  style: TextStyle(color: Colors.amber),
                                ),
                                Text(
                                  "4.0",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          FadeInRight(
                            duration: Duration(milliseconds: 500),
                            child: const Text(
                              """was the largest corporation in the world by various measures. The EIC had its own armed forces in the form of the company's three Presidency armies, totalling about 260,000 soldiers, twice the size of the British army at the time.[5] The operations of the company had a profound effect on the global balance of trade, almost single-handedly[6] reversing the trend of eastward drain of Western bullion, seen since Roman times.[7]Originally chartered as the Governor and Company of Merchants of London Trading into the East-Indies",[8][9] the company rose to account for half of the world's trade during the mid-1700s and early 1800s,[10] particularly in basic commodities including cotton, silk, indigo dye, sugar, salt, spices, saltpetre, tea, and opium.
                              The company also ruled the beginnings of the British Empire in India.[10""",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Positioned(
              top: 50,
              right: 20,
              child: RichText(
                text: TextSpan(
                    text: "${page + 1}/",
                    style: TextStyle(fontSize: 30, color: Colors.white),
                    children: [
                      TextSpan(
                        text: "4",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )
                    ]),
              ))
        ],
      ),
    );
  }
}
