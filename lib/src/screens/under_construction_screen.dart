import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:async';
import '../widgets/sections_image_background.dart';
import '../widgets/section_background.dart';

class UnderConstruction extends StatefulWidget {
  final String heroTag;
  const UnderConstruction({ Key? key, required this.heroTag }) : super(key: key);

  @override
  State<UnderConstruction> createState() => _UnderConstructionState();
}

class _UnderConstructionState extends State<UnderConstruction> with TickerProviderStateMixin{
  late StreamSubscription<AccelerometerEvent> _streamSubscription;
  late AnimationController fadeInAnimationController;
  late AnimationController fadeOutAnimationController;
  late Animation<double> fadeIn;
  late Animation<double> fadeInImage;
  late Animation<double> fadeOut;
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
        children: [
          const SectionsBackground(),
          SectionImageBackground(y: y, x: x, fadeInAnimationController: fadeInAnimationController, fadeInImage: fadeInImage, imageRoute: 'assets/img/under_construction.jpg',),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            top: 70 + (y * 9),
            bottom: (y * -9),
            right: (x * -9),
            left: 35 + (x * 9),
            child: Hero(
              tag: widget.heroTag,
              child: Text(
                'Ooopss!',
                style: Theme.of(context).textTheme.headline4,
              )
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            top: 200 + (y * 6),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('import package:flutter/material.dart;',style: Theme.of(context).textTheme.subtitle2,),
                        const SizedBox(height: 20.0,),
                        Text('class UnderConstruction extends StatelessWidget {',style: Theme.of(context).textTheme.subtitle2,),
                        const SizedBox(height: 20.0,),
                        Text(' @override',style: Theme.of(context).textTheme.subtitle2,),
                        Text(' Widget build(BuildContext context) {',style: Theme.of(context).textTheme.subtitle2,),
                        const SizedBox(height: 20.0,),
                        DefaultTextStyle(
                          style: Theme.of(context).textTheme.headline4!.merge(TextStyle(color: Theme.of(context).colorScheme.brightness == Brightness.dark ? Theme.of(context).primaryColor : const Color(0xFF474747), fontSize: 40.0, fontWeight: FontWeight.w900)),
                          child: AnimatedTextKit(
                            pause: const Duration(milliseconds: 3000),
                            repeatForever: true,
                            animatedTexts: [
                              TypewriterAnimatedText('// TODO: This screen is under construction')
                            ]
                          ),
                        ),
                        const SizedBox(height: 20.0,),
                        Text('    return Container(',style: Theme.of(context).textTheme.subtitle2,),
                        const SizedBox(height: 20.0,),
                        Text('    );',style: Theme.of(context).textTheme.subtitle2,),
                        Text('  }',style: Theme.of(context).textTheme.subtitle2,),
                        Text('}',style: Theme.of(context).textTheme.subtitle2,),
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