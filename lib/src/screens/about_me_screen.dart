// TODO: Refactor, include user data into model
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import '../widgets/about_me_background.dart';
import '../widgets/home_screen_background.dart';

class AboutMe extends StatefulWidget {
  String heroTag;
  AboutMe({Key? key, required this.heroTag}) : super(key: key);

  @override
  State<AboutMe> createState() => _AboutMeState();
}

class _AboutMeState extends State<AboutMe> {
  late StreamSubscription<AccelerometerEvent> _streamSubscription;
  double x = 0.0;
  double y = 0.0;
  @override
  void initState() {
    _streamSubscription = accelerometerEvents.listen((event) {
      setState(() {
        x = event.x;
        y = event.y;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const AboutMeBackground(),
          CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: 300.0,
                flexibleSpace: Stack(
                  fit: StackFit.expand,
                  children: [
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 300),
                      top: 0,
                      bottom: y * -5,
                      right: x * -5,
                      left: x * 5,
                      child: ShaderMask(
                        // TODO: Add transition in animation to avoid suddenly image appearance
                        shaderCallback: (rect) {
                          return LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: const [0.0, 0.90],
                            colors: [
                              Theme.of(context)
                                  .scaffoldBackgroundColor
                                  .withOpacity(0.3),
                              Colors.transparent
                            ],
                          ).createShader(
                              Rect.fromLTRB(0, 0, rect.width, rect.height));
                        },
                        blendMode: BlendMode.dstIn,
                        child: Image.asset(
                          'assets/img/about_me.jpg',
                          // height: 400.0,
                          fit: BoxFit.cover,
                          color: Theme.of(context).scaffoldBackgroundColor,
                          colorBlendMode: BlendMode.color,
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 300),
                      top: 100 + (y * 7),
                      bottom: (y * -7),
                      right: (x * -7),
                      left: 40 + (x * 7),
                      child: Hero(
                          tag: widget.heroTag,
                          child: Text(
                            'About Me',
                            style: Theme.of(context).textTheme.headline4,
                          )),
                    )
                  ],
                ),
              ),
            ],
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            top: 180 + (y * 6),
            bottom: (y * -6),
            right: (x * -6),
            left: 40 + (x * 6),
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate([
                    // TODO: Fix text style
                    Text('Duis eget justo mi. In et tincidunt nibh. Praesent et justo sed enim rutrum vulputate. Nunc quis ante commodo sapien congue suscipit. Vivamus nec condimentum sapien.'),
                    SizedBox(height: 50.0,),
                    Text('Duis eget justo mi. In et tincidunt nibh. Praesent et justo sed enim rutrum vulputate. Nunc quis ante commodo sapien congue suscipit. Vivamus nec condimentum sapien. Quisque sit amet sapien a orci suscipit semper ac eget orci. Nulla facilisi. Nunc et tortor mi. Praesent sodales aliquet lorem, at rutrum arcu vestibulum eget.'),
                    SizedBox(height: 50.0,), 
                    Text('Duis eget justo mi. In et tincidunt nibh. Praesent et justo sed enim rutrum vulputate. Nunc quis ante commodo sapien congue suscipit. Vivamus nec condimentum sapien. Quisque sit amet sapien a orci suscipit semper ac eget orci. Nulla facilisi. Nunc et tortor mi. Praesent sodales aliquet lorem, at rutrum arcu vestibulum eget.'),
                  ]),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

// CustomScrollView(
          //   slivers: <Widget>[
          //     const SliverAppBar(
          //       expandedHeight: 200.0,
          //       flexibleSpace: Center(child: Text('About me')),
          //     ),
              // SliverList(
              //   delegate: SliverChildListDelegate(
              //     [
              //       Container(color: Colors.red, height: 150.0),
              //       Container(color: Colors.purple, height: 150.0),
              //       Container(color: Colors.green, height: 150.0),
              //       Container(color: Colors.red, height: 150.0),
              //       Container(color: Colors.purple, height: 150.0),
              //       Container(color: Colors.green, height: 150.0),
              //       Container(color: Colors.red, height: 150.0),
              //       Container(color: Colors.purple, height: 150.0),
              //       Container(color: Colors.green, height: 150.0),
              //       Container(color: Colors.red, height: 150.0),
              //       Container(color: Colors.purple, height: 150.0),
              //       Container(color: Colors.green, height: 150.0),
              //     ],
              //   )
              // )