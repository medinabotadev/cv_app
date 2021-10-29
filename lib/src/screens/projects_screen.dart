import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:async';
import '../models/project.dart';
import '../providers/projects_provider.dart';
import '../widgets/section_background.dart';
import '../widgets/sections_image_background.dart';
import '../widgets/project_slide_item.dart';

class ProjectsScreen extends StatefulWidget {
  final String heroTag;
  const ProjectsScreen({ Key? key, required this.heroTag }) : super(key: key);

  @override
  _ProjectsScreenState createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> with TickerProviderStateMixin{
  ProjectsProvider projectsProvider = ProjectsProvider();
  late StreamSubscription<AccelerometerEvent> _streamSubscription;
  late AnimationController fadeInAnimationController;
  late AnimationController colorWaveController;
  late AnimationController fadeOutAnimationController;
  late Animation<double> fadeInImage;
  late Animation<double> fadeIn;
  late Animation<double> fadeOut;
  late List<Project> projectList;
  // Color? waveColor;
  late Color? nextColor;
  late Color? previousColor;
  late Animation colorTween;
  double x = 0.0;
  double y = 0.0;
  @override
  void initState() {
    projectList = projectsProvider.getProjects();
    // waveColor = projectList[0].themeColor;
    nextColor = projectList[0].themeColor;
    previousColor = projectList[0].themeColor;
    _streamSubscription = accelerometerEvents.listen((event) {
      setState(() {
        x = event.x;
        y = event.y;
      });
    });
    fadeInAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 4000));
    colorWaveController     = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));
    colorTween = ColorTween(begin: previousColor, end: nextColor).animate(colorWaveController);
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
    colorWaveController.dispose();
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
                      fadeOutAnimationController.dispose();
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
          AnimatedBuilder(
            animation: colorTween,
            builder: (BuildContext context, child) {
              return SectionsBackground(waveColor: colorTween.value,);
            }
          ),
          SectionImageBackground(y: y, x: x, fadeInAnimationController: fadeInAnimationController, fadeInImage: fadeInImage, imageRoute: 'assets/img/projects.jpg',),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            top: 70 + (y * 9),
            bottom: (y * -9),
            right: (x * -9),
            left: 35 + (x * 9),
            child: Hero(
              tag: widget.heroTag,
              child: Text(
                'Projects',
                style: Theme.of(context).textTheme.headline4,
              )
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            top: -40 + (y * 6),
            bottom: (y * -6),
            right: 0,//(x * -9),
            left: 0,//35 + (x * 9),
            child: CarouselSlider.builder(
              itemCount: projectList.length, 
              options: CarouselOptions(
                aspectRatio: 0.80,
                viewportFraction:  0.70,
                enlargeCenterPage: true,
                autoPlay: true,
                autoPlayAnimationDuration: const Duration(milliseconds: 1000),
                enlargeStrategy: CenterPageEnlargeStrategy.scale,
                onPageChanged: (int index, carouselPageChangedReason){
                  previousColor = nextColor;
                  nextColor = projectList[index].themeColor;
                  colorTween = ColorTween(begin: previousColor, end: nextColor).animate(colorWaveController);
                  colorWaveController.reset();
                  colorWaveController.forward(from: 0.0);
                }
              ),
              itemBuilder: (BuildContext context, int index, int secondIndex){
                return CarouselSliderItem(project: projectList[index]);
              },
            ) 
          )
        ],
      ),
    );
  }
}