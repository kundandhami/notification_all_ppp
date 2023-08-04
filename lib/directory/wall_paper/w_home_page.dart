import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class WHomePage extends StatefulWidget {
  const WHomePage({Key? key}) : super(key: key);

  @override
  State<WHomePage> createState() => _WHomePageState();
}

String street = "assets/img/street/";

class _WHomePageState extends State<WHomePage> {
  List data = [
    {
      'images': "assets/img/I walk the streets of this sweltering city.jpg",
      "title": "Street Art"
    },
    {'images': "assets/img/M light.jpg", "title": "Wild Life"},
    {'images': "assets/img/M light (1).jpg", "title": "Nature"},
    {'images': "assets/img/mountain with forest.jpg", "title": "City"},
    {
      'images': "assets/img/naturaleza deporte ardilla.jpg",
      "title": "Motivation"
    },
    {
      'images': "assets/img/Vintage anime screenshot from Akira.jpg",
      "title": "Bikes"
    },
    {'images': "assets/img/vulcão cuspindo gelo.jpg", "title": "Love"},
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
    "assets/img/river pollution.jpg",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Icon(
          Icons.menu,
          color: Colors.black,
        ),
        title: Text(
          "Paper",
          style: TextStyle(color: Colors.black87, fontSize: 22),
        ),
        backgroundColor: Colors.white,
        elevation: .5,
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: data.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              WSecoundPage(name: data[index]['title']),
                        ));
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 15),
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: AssetImage(data[index]['images']),
                            fit: BoxFit.cover)),
                    alignment: Alignment.center,
                    child: Text(
                      data[index]['title'],
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                );
              },
            ),
          ),
          StaggeredGridView.countBuilder(
            padding:
                const EdgeInsets.symmetric(horizontal: 15).copyWith(top: 20),
            crossAxisCount: 4,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            primary: false,
            itemCount: images.length,
            staggeredTileBuilder: (int index) =>
                new StaggeredTile.count(1, index.isEven ? 1.2 : 1.8),
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return FullView(images: images[index]);
                    },
                  ));
                },
                child: Container(
                  height: index % 2 == 0 ? 150 : 300,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: AssetImage(images[index]), fit: BoxFit.cover)),
                ),
              );
            },
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

class WSecoundPage extends StatefulWidget {
  String name;
  WSecoundPage({Key? key, required this.name}) : super(key: key);

  @override
  State<WSecoundPage> createState() => _WSecoundPageState();
}

class _WSecoundPageState extends State<WSecoundPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.name,
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
        backgroundColor: Colors.black,
        elevation: .5,
      ),
      body: StaggeredGridView.countBuilder(
        padding: EdgeInsets.symmetric(horizontal: 15).copyWith(top: 10),
        crossAxisCount: 4,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        primary: false,
        itemCount: streets.length,
        staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return FullView(images: streets[index]);
                },
              ));
            },
            child: Container(
              key: UniqueKey(),
              height: index % 2 == 0 ? 150 : 300,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white, width: 2),
                  image: DecorationImage(
                      image: AssetImage(streets[index]), fit: BoxFit.cover)),
            ),
          );
        },
      ),
    );
  }
}

class FullView extends StatelessWidget {
  FullView({Key? key, required this.images}) : super(key: key);
  final String images;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Image.asset(
          images,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

List streets = [
  "${street}a black and white line art drawing of a village sc.jpg",
  "${street}Chaotic stunning san francisco.jpg",
  "${street}Chaotic stunning san francisco (1).jpg",
  "${street}Ciutat de Balaguer.jpg",
  "${street}Ciutat de Balaguer (1).jpg",
  "${street}cyber punk.jpg",
  "${street}cyber punk (1).jpg",
  "${street}cyberpunk themed alleyway in the style of cyberpun.jpg",
  "${street}Edmonton city skyline on the coldest day.jpg",
  "${street}I drive my vehicle on an icy country road.jpg",
  "${street}Khenifra Streets.jpg",
  "${street}Khenifra Streets (1).jpg",
  "${street}La tristeza del alma.jpg",
  "${street}Multiple connecting tunnels in antartica bellow th.jpg",
  "${street}Multiple connecting tunnels in antartica bellow th (1).jpg",
  "${street}paris with snow.jpg",
  "${street}paris with snow (1).jpg",
  "${street}pintura digital.jpg",
  "${street}PLAYSTATION ONE OLD.jpg",
  "${street}Snow Road in wild forest with tiger.jpg",
  "${street}Snow Road in wild forest with tiger (1).jpg",
  "${street}snowfall in kolkata.jpg",
  "${street}techno street grey color.jpg",
  "${street}Tel Aviv city in light snow during day time.jpg",
  "${street}Tel Aviv city in light snow during day time (1).jpg",
  "${street}Vintage anime screenshot from Akira (1).jpg",
  "${street}Vintage anime screenshot from Akira (2).jpg",
  "${street}Wavy road through a snowy forest. It snows.jpg",
  "${street}Wavy road through a snowy forest. It snows (1).jpg",
  "${street}zombie.jpg",
  "${street}zombie (1).jpg",
];
