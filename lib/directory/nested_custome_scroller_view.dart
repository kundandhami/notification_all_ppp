import 'package:flutter/material.dart';

class CustomeScrollerView extends StatefulWidget {
  const CustomeScrollerView({Key? key}) : super(key: key);

  @override
  State<CustomeScrollerView> createState() => _CustomeScrollerViewState();
}

class _CustomeScrollerViewState extends State<CustomeScrollerView> {
  ScrollController _scrollController = ScrollController();
  bool get _isSliverAppBarExpanded {
    return _scrollController.hasClients &&
        _scrollController.offset > (200 - kToolbarHeight);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          // controller: _scrollController,
          slivers: [
            SliverAppBar(
              // show and hide SliverAppBar Title
              title:
                  _isSliverAppBarExpanded ? const Text('App Bar Title') : null,
              backgroundColor: Colors.black,
              centerTitle: false,
              pinned: true,
              snap: false,
              floating: false,
              expandedHeight: 200,
              // show and hide FlexibleSpaceBar title
              flexibleSpace: _isSliverAppBarExpanded
                  ? null
                  : FlexibleSpaceBar(
                      title: Text(
                        'Beach',
                        textScaleFactor: 1,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ),
                      background: Image.asset(
                        'assets/img/naturaleza deporte ardilla.jpg',
                        fit: BoxFit.fill,
                      ),
                    ),
            ),
            SliverToBoxAdapter(
              child: ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: 20,
                itemBuilder: (context, index) => Container(
                  height: 100,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      clipBehavior: Clip.none,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              gradient: RadialGradient(
                  radius: .5,
                  colors: [Colors.black, Colors.transparent, Colors.red])),
        ),
        Center(
          child: Opacity(
            opacity: shrinkOffset / 200,
            child: Text(
              "My Title",
              style: TextStyle(color: Colors.green, fontSize: 28),
            ),
          ),
        ),
        Positioned(
            top: 200 / 4 - shrinkOffset,
            left: 60,
            child: Opacity(
              opacity: (1 - shrinkOffset / 200),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 100,
                child: CircleAvatar(
                  backgroundColor: Colors.amberAccent,
                  radius: 90,
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
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
