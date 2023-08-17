import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PracticeAll extends StatefulWidget {
  const PracticeAll({Key? key}) : super(key: key);

  @override
  State<PracticeAll> createState() => _PracticeAllState();
}

class _PracticeAllState extends State<PracticeAll> {
  int value = 0;
  Map<int, Widget> tab = {
    0: Container(
        padding: EdgeInsets.symmetric(
          vertical: 15,
        ),
        child: Text(
          'All Product',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        )),
    1: Container(
        padding: EdgeInsets.symmetric(
          vertical: 15,
        ),
        child: Text(
          'See All',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ))
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[700],
        leading: Icon(Icons.menu),
        title: Text("MENU"),
        actions: [Icon(Icons.shopping_bag_outlined)],
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            child: CupertinoSlidingSegmentedControl(
                thumbColor: Colors.amber,
                groupValue: value,
                children: tab,
                onValueChanged: (va) {
                  value = va ?? 0;
                }),
          ),
          SizedBox(
            height: 20,
          ),
          DefaultTabController(
              length: 5,
              child: TabBar(
                isScrollable: true,
                labelStyle: TextStyle(fontWeight: FontWeight.w800),
                indicatorSize: TabBarIndicatorSize.label,
                labelColor: Color(0xfff03536),
                unselectedLabelColor: Colors.amber,
                indicatorColor: Colors.red,
                indicator: MaterialDesignIndicator(
                    indicatorColor: Colors.purpleAccent, indicatorHeight: 5),
                tabs: [
                  Tab(
                    text: "Burger",
                  ),
                  Tab(
                    text: "Burger",
                  ),
                  Tab(
                    text: "Burger",
                  ),
                  Tab(
                    text: "Burger",
                  ),
                  Tab(
                    text: "Burger",
                  )
                ],
              ))
        ],
      ),
    );
  }
}

class MaterialDesignIndicator extends Decoration {
  final double indicatorHeight;
  final Color indicatorColor;

  const MaterialDesignIndicator({
    required this.indicatorHeight,
    required this.indicatorColor,
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return MaterialDesignIndicatorPainter(
      indicatorHeight: indicatorHeight,
      indicatorColor: indicatorColor,
    );
  }
}

class MaterialDesignIndicatorPainter extends BoxPainter {
  final double indicatorHeight;
  final Color indicatorColor;

  MaterialDesignIndicatorPainter({
    required this.indicatorHeight,
    required this.indicatorColor,
  });

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Rect rect = Offset(
          offset.dx,
          (configuration.size!.height - indicatorHeight) + offset.dy,
        ) &
        Size(configuration.size!.width, indicatorHeight);
    final Paint paint = Paint()..color = indicatorColor;
    canvas.drawRect(rect, paint);
  }
}

class RotatedBoxs extends PageRouteBuilder {
  Widget child;
  RotatedBoxs({required this.child})
      : super(
            pageBuilder: (context, Animation<double> animation,
                Animation<double> animation1) {
              return child;
            },
            opaque: false,
            barrierColor: null,
            barrierLabel: null,
            maintainState: true,
            transitionDuration: Duration(milliseconds: 600),
            transitionsBuilder: (context, Animation<double> animation,
                Animation<double> animation1, Widget child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            });
}

///TODO: CustomScrollerView App Bar Play
/*
  late ScrollController scrollController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController = ScrollController()
      ..addListener(() {
        setState(() {});
      });
  }

  bool get _isSliverAppBarExpanded =>
      scrollController.hasClients &&
      scrollController.offset > (200 - kToolbarHeight);

return SafeArea(
child: Scaffold(
body: CustomScrollView(
controller: scrollController,
slivers: [
// SliverAppBar(
//   // show and hide SliverAppBar Title
//   title: _isSliverAppBarExpanded
//       ? const Text(
//           'App Bar Title',
//           style: TextStyle(color: Colors.redAccent),
//         )
//       : null,
//   backgroundColor: Colors.black,
//   centerTitle: false,
//   pinned: true,
//   snap: false,
//   floating: false,
//   expandedHeight: 200,
//   // show and hide FlexibleSpaceBar title
//   flexibleSpace: _isSliverAppBarExpanded
//       ? null
//       : FlexibleSpaceBar(
//           title: Text(
//             'Beach',
//             textScaleFactor: 1,
//             style: TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 30),
//           ),
//           background: Image.asset(
//             'assets/img/naturaleza deporte ardilla.jpg',
//             fit: BoxFit.fill,
//           ),
//         ),
// ),
SliverPersistentHeader(delegate: Scrolleable(), pinned: true),
SliverToBoxAdapter(
child: ListView.builder(
primary: false,
shrinkWrap: true,
itemCount: 20,
itemBuilder: (context, index) => Container(
height: 100,
),
),
)
],
)),
);
class Scrolleable extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    print("shrinkOffset--$shrinkOffset");
    return Stack(
      fit: StackFit.expand,
      clipBehavior: Clip.none,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          color: Colors.black87,
          child: Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.white,
          ),
        ),
        Opacity(
          opacity: shrinkOffset / 200,
          child: Center(
            child: Text(
              "Hey AppBar Title",
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
          ),
        ),
        Positioned(
            top: 200 / 4 - shrinkOffset,
            left: MediaQuery.of(context).size.width / 3,
            child: Opacity(
              opacity: 1 - shrinkOffset / 200,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  "assets/img/Vintage anime screenshot from Akira.jpg",
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ))
      ],
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => 200;

  @override
  // TODO: implement minExtent
  double get minExtent => 50;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
*/

///TODO:navigation
//   GlobalKey<NavigatorState>
/*

Future<dynamic>? navigate(String path, {Object? args}) {
  return navigatorekey.currentState?.pushNamed(path, arguments: args);
}

Future<dynamic>? navigateAndReplace(String path, {Object? args}) {
  return navigatorekey.currentState
      ?.pushReplacementNamed(path, arguments: args);
}

Future<dynamic>? navigateAndRemoveUntil(String path, {Object? args}) {
  return navigatorekey.currentState?.pushNamedAndRemoveUntil(
      path, (Route<dynamic> route) => false,
      arguments: args);
}

goBack() {
  return navigatorekey.currentState?.pop();
}
*/
