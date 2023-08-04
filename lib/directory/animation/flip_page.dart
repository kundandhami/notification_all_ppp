import 'package:flutter/material.dart';

class FlipPage extends StatefulWidget {
  const FlipPage({Key? key}) : super(key: key);

  @override
  State<FlipPage> createState() => _FlipPageState();
}

class _FlipPageState extends State<FlipPage> {
  final pageflipbuilder = GlobalKey<PageFlipBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageFlipBuilder(
        key: pageflipbuilder,
        frontBuilder: (_) => LighHomePage(),
        backBuilder: (_) => DarkHomePage(),
      ),
    );
  }
}

class PageFlipBuilder extends StatefulWidget {
  final WidgetBuilder frontBuilder;
  final WidgetBuilder backBuilder;
  const PageFlipBuilder(
      {Key? key, required this.backBuilder, required this.frontBuilder})
      : super(key: key);

  @override
  State<PageFlipBuilder> createState() => PageFlipBuilderState();
}

class PageFlipBuilderState extends State<PageFlipBuilder> {
  void onFlip() {}
  @override
  Widget build(BuildContext context) {
    return widget.frontBuilder(context);
  }
}

class DarkHomePage extends StatelessWidget {
  const DarkHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class LighHomePage extends StatelessWidget {
  const LighHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 530,
          width: 330,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.teal,
                      offset: Offset(0, 12),
                    ),
                    BoxShadow(
                      color: Colors.white.withOpacity(1),
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.tealAccent,
                          Colors.tealAccent.withOpacity(.1),
                          Colors.tealAccent
                        ])),
              )
            ],
          ),
        ),
      ),
    );
  }
}
