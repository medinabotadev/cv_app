import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:timelines/timelines.dart';
import 'dart:async';
import '../models/work_experience.dart';
import '../providers/work_experience_provider.dart';
import '../widgets/section_background.dart';
import '../widgets/sections_image_background.dart';

class WorkExperienceScreen extends StatefulWidget {
  final String heroTag;
  const WorkExperienceScreen({ Key? key, required this.heroTag }) : super(key: key);

  @override
  _WorkExperienceScreenState createState() => _WorkExperienceScreenState();
}

class _WorkExperienceScreenState extends State<WorkExperienceScreen> with TickerProviderStateMixin{
  WorkExperienceProvider workExperienceProvider = WorkExperienceProvider();
  late StreamSubscription<AccelerometerEvent> _streamSubscription;
  late AnimationController fadeInAnimationController;
  late AnimationController fadeOutAnimationController;
  late Animation<double> fadeInImage;
  late Animation<double> fadeIn;
  late Animation<double> fadeOut;
  late List<WorkExperience> workExperience;
  double x = 0.0;
  double y = 0.0;
  @override
  void initState() {
    workExperience = workExperienceProvider.getWorkExperience();
    _streamSubscription = accelerometerEvents.listen((event) {
      setState(() {
        x = event.x;
        y = event.y;
      });
    });
    fadeInAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 4000));
    fadeInImage = Tween(begin: 0.0, end: 0.4).animate(fadeInAnimationController);
    fadeOutAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));
    fadeOut = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: fadeOutAnimationController, curve: const Interval(0.0, 0.50)));
    fadeIn = Tween(begin: 0.0, end: 1.0).animate(fadeInAnimationController);
    fadeInAnimationController.forward();
    super.initState();
    
  }
  @override
  void dispose() {
    _streamSubscription.cancel();
    fadeInAnimationController.dispose();
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
          SectionImageBackground(y: y, x: x, fadeInAnimationController: fadeInAnimationController, fadeInImage: fadeInImage, imageRoute: 'assets/img/work_experience.jpg',),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            top: 70 + (y * 9),
            bottom: (y * -9),
            right: (x * -9),
            left: 35 + (x * 9),
            child: Hero(
              tag: widget.heroTag,
              child: Text(
                'Work Experience',
                style: Theme.of(context).textTheme.headline4,
              )
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            top: 155 + (y * 6),
            bottom: (y * -6),
            right: (x * -6),
            left: 00 + (x * 6),
            child: AnimatedBuilder(
                animation: Listenable.merge([fadeInAnimationController, fadeOutAnimationController]),
                builder: (BuildContext context, child) {
                  return Padding(
                  padding: const EdgeInsets.only(right: 10.0, left: 10.0),
                  child: Opacity(
                    opacity: fadeIn.value - fadeOut.value,
                    child: Timeline.tileBuilder(
                      theme: TimelineThemeData(
                        indicatorTheme: IndicatorThemeData(
                          color: Theme.of(context).colorScheme.brightness != Brightness.light ? Theme.of(context).primaryColor : Theme.of(context).hintColor,
                          size: 20.0
                        ),
                        connectorTheme: ConnectorThemeData(
                          color: Theme.of(context).hintColor
                        )
                      ),
                      builder: TimelineTileBuilder.fromStyle(
                        itemExtent: 150.0,
                        endConnectorStyle: ConnectorStyle.solidLine,
                        contentsAlign: ContentsAlign.alternating,
                        connectorStyle: ConnectorStyle.solidLine,
                        indicatorStyle: IndicatorStyle.outlined,
                        itemCount: workExperience.length,
                        oppositeContentsBuilder: (BuildContext context, int index){
                          return SizedBox(
                            height: 100.0,
                            // color: Colors.red,
                            child: Center(child: Text(workExperience[index].period, style: Theme.of(context).textTheme.subtitle1,)),
                          );
                        },
                        contentsBuilder: (BuildContext context, int index){
                          return SizedBox(
                            height: 100.0,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(workExperience[index].companyName, style: Theme.of(context).textTheme.subtitle2, overflow: TextOverflow.ellipsis, maxLines: 1,),
                                  // const SizedBox(height: 10.0,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.location_pin, size: 14.0,),
                                      const SizedBox(width: 5.0,),
                                      Text(workExperience[index].location, style: Theme.of(context).textTheme.subtitle1!.merge(const TextStyle(fontSize: 13.0)), overflow: TextOverflow.ellipsis, maxLines: 1,),
                                    ],
                                  ),
                                  Text(workExperience[index].description, style: Theme.of(context).textTheme.subtitle1, overflow: TextOverflow.ellipsis, maxLines: 1,),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    )
                  ),
                );
              }
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            top: 380 + (y * 3),
            bottom: (y * -3),
            right: (x * -3),
            left: 20 + (x * 3),
            child: Row(
              children: <Widget>[
                const Icon(Icons.info_outline_rounded, size: 14.0,),
                const SizedBox(width: 5.0,),
                Text('Tap on company name to see job descriptions', style: Theme.of(context).textTheme.subtitle1!.merge(const TextStyle(fontSize: 13.0)))
              ],
            )
          )
        ],
      ),
    );
  }
}