import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../providers/splash_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{
        SplashProvider      splashProvider = SplashProvider();
  late  AnimationController animationController;
  late  Animation<double>   fadeIn;
  late  Animation<double>   moveUp;
  late  Animation<double>   scaleIn;
  late  Animation<double>   scaleOut;
  late  Animation<double>   fadeOut;
  @override
  void initState() {
    
    animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 3000));
    fadeIn  = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animationController, curve: const Interval(0.0, 0.50))
    );
    moveUp  = Tween(begin: 100.0, end: -100.0).animate(animationController);
    scaleIn   = Tween(begin: 0.0, end: 2.0).animate(
      CurvedAnimation(parent: animationController, curve: const Interval(0.0, 0.50))
    );
    scaleOut   = Tween(begin: 0.0, end: 2.0).animate(
      CurvedAnimation(parent: animationController, curve: const Interval(0.50, 1.0))
    );
    fadeOut = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animationController, curve: const Interval(0.50, 1.0))
    );

    animationController.addListener(() {
      if (animationController.status == AnimationStatus.completed) {
        splashProvider.navigateToHome(context);
        // animationController.repeat();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Theme.of(context).colorScheme.brightness == Brightness.light ? Brightness.dark : Brightness.light,
    ));
    animationController.forward();
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          AnimatedBuilder(
            animation: animationController,
            builder: (BuildContext context, child) {
              return CustomPaint(
                size: MediaQuery.of(context).size,
                painter: _SplashBackgroundWaver(primaryColor: Theme.of(context).primaryColor.withOpacity(1.0 - fadeOut.value), secondaryColor: Theme.of(context).colorScheme.secondary.withOpacity(1.0 - fadeOut.value))
              );
            }
          ),
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 12.5, sigmaY: 12.5
            ),
            child: Container(
              height: double.infinity,
            ),
          ),
          AnimatedBuilder(
            animation: animationController,
            builder: (BuildContext context, child){
              return Transform.translate(
                offset: Offset(0, moveUp.value),
                child: Opacity(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Jesús', style: Theme.of(context).textTheme.headline2!.merge(TextStyle(fontWeight: FontWeight.w100, fontStyle: FontStyle.italic  , color: Theme.of(context).colorScheme.brightness != Brightness.light ? Theme.of(context).primaryColor : Theme.of(context).hintColor)),),
                        Text('Medina', style: Theme.of(context).textTheme.headline2!.merge(TextStyle(fontWeight: FontWeight.w700, fontStyle: FontStyle.italic , color: Theme.of(context).colorScheme.brightness != Brightness.light ? Theme.of(context).primaryColor : Theme.of(context).hintColor))),
                        Row(
                          children: <Widget>[
                            SvgPicture.asset('assets/img/flutter.svg'),
                          ],
                        )
                      ],
                    ),
                  ),
                  opacity: fadeIn.value - fadeOut.value
                ),
              );
            }
          ),
        ],
      )
    );
  }
}

class _SplashBackgroundWaver extends CustomPainter{
  final Color primaryColor;
  final Color secondaryColor;
  _SplashBackgroundWaver({
    required this.primaryColor,
    required this.secondaryColor
  });
  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Rect.fromCircle(center: Offset(size.width, size.height * 0.80), radius: 140);
    final Gradient gradient = LinearGradient(colors: [
        primaryColor,
        secondaryColor,
    ]);
    final brush             = Paint();
          brush.color       = primaryColor;
          brush.style       = PaintingStyle.fill;
          brush.strokeWidth = 10.0;
          brush.shader      = gradient.createShader(rect);

    final path = Path();
          path.moveTo(size.width, 0);
          path.quadraticBezierTo(size.width * 0.75, size.height * 0.25, size.width * 0.90, size.height * 0.50);
          path.quadraticBezierTo(size.width * 0.65, size.height * 0.75, size.width * 0.75, size.height);
          path.lineTo(size.width, size.height);

    canvas.drawPath(path, brush);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
  
}