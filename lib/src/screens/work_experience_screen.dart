import 'package:flutter/material.dart';
import '../widgets/sections_image_background.dart';
import 'dart:async';
import 'package:sensors_plus/sensors_plus.dart';
import '../widgets/about_me_background.dart';

class WorkExperienceScreen extends StatefulWidget {
  final String heroTag;
  const WorkExperienceScreen({ Key? key, required this.heroTag }) : super(key: key);

  @override
  _WorkExperienceScreenState createState() => _WorkExperienceScreenState();
}

class _WorkExperienceScreenState extends State<WorkExperienceScreen> with SingleTickerProviderStateMixin{
  late StreamSubscription<AccelerometerEvent> _streamSubscription;
  late AnimationController fadeInAnimationController;
  late Animation<double> fadeInImage;
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
    fadeInImage = Tween(begin: 0.0, end: 0.4).animate(fadeInAnimationController);
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
      body: Stack(
        children: <Widget>[
          const SectionsBackground(),
          SectionImageBackground(y: y, x: x, fadeInAnimationController: fadeInAnimationController, fadeInImage: fadeInImage, imageRoute: 'assets/img/work_experience.jpg',),
        ],
      ),
    );
  }
}