import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:async';
import '../models/user.dart';
import '../providers/home_screen_provider.dart';
import '../widgets/section_background.dart';
import '../widgets/sections_image_background.dart';

class AboutMe extends StatefulWidget {
  final String heroTag;
  const AboutMe({Key? key, required this.heroTag}) : super(key: key);

  @override
  State<AboutMe> createState() => _AboutMeState();
}

class _AboutMeState extends State<AboutMe> with TickerProviderStateMixin {
  HomeScreenProvider homeScreenProvider = HomeScreenProvider();
  late StreamSubscription<AccelerometerEvent> _streamSubscription;
  late AnimationController fadeInAnimationController;
  late AnimationController fadeOutAnimationController;
  late Animation<double> fadeIn;
  late Animation<double> fadeInImage;
  late Animation<double> fadeOut;
  late User user;
  double x = 0.0;
  double y = 0.0;
  @override
  void initState() {
    user = homeScreenProvider.getMainUser();
    _streamSubscription = accelerometerEvents.listen((event) {
      setState(() {
        x = event.x;
        y = event.y;
      });
    });

    fadeInAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 4000));
    fadeIn = Tween(begin: 0.0, end: 1.0).animate(fadeInAnimationController);
    fadeInImage = Tween(begin: 0.0, end: 0.4).animate(fadeInAnimationController);
    fadeOutAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));
    fadeOut = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: fadeOutAnimationController, curve: const Interval(0.0, 0.50)));
    fadeInAnimationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    fadeInAnimationController.dispose();
    fadeOutAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          color: Theme.of(context).iconTheme.color,
          onPressed: fadeIn.value < 1.0 
                ? null
                : () {
                  fadeOutAnimationController.forward();
                  void onPressed() {
                    fadeOutAnimationController.addListener(() {
                      if (fadeOutAnimationController.status == AnimationStatus.completed) {
                      Navigator.of(context).pop();
                      fadeInAnimationController.reset();
                      fadeOutAnimationController.reset();
                      fadeOutAnimationController.removeListener(onPressed);
                    }
                  }
                );
              }
            fadeOutAnimationController.addListener(onPressed);
          },
        ),
      ),
      body: Stack(
        children: <Widget>[
          const SectionsBackground(),
          SectionImageBackground(y: y, x: x, fadeInAnimationController: fadeInAnimationController, fadeInImage: fadeInImage, imageRoute: 'assets/img/about_me.jpg',),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            top: 70 + (y * 9),
            bottom: (y * -9),
            right: (x * -9),
            left: 35 + (x * 9),
            child: Hero(
              tag: widget.heroTag,
              child: Text(
                'About Me',
                style: Theme.of(context).textTheme.headline4,
              )
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            top: 155 + (y * 6),
            bottom: (y * -6),
            right: (x * -6),
            left: 35 + (x * 6),
            child: AnimatedBuilder(
                animation: Listenable.merge([fadeInAnimationController, fadeOutAnimationController]),
                builder: (BuildContext context, child) {
                  return Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Opacity(
                    opacity: fadeIn.value - fadeOut.value,
                    child: Column(
                      children: <Widget>[
                        Text(user.bioSection1!,style: Theme.of(context).textTheme.subtitle2,),
                        const SizedBox(height: 20.0,),
                        Text(user.bioSection2!,style: Theme.of(context).textTheme.subtitle2,),
                        const SizedBox(height: 20.0,),
                        Text(user.bioSection3!,style: Theme.of(context).textTheme.subtitle2,),
                      ]
                    ),
                  ),
                );
              }
            ),
          )
        ],
      ),
    );
  }
}
