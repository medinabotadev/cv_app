import 'dart:ui';

import 'package:flutter/material.dart';

class SectionsBackground extends StatefulWidget {
  final Color? waveColor;
  const SectionsBackground({ Key? key, this.waveColor }) : super(key: key);

  @override
  _SectionsBackgroundState createState() => _SectionsBackgroundState();
}

class _SectionsBackgroundState extends State<SectionsBackground> with TickerProviderStateMixin{
  late AnimationController animationWaveController;
  late Animation<double>   waveAnimation;
  @override
  void initState() {
    animationWaveController = AnimationController(vsync: this, duration: const Duration(milliseconds: 5000));
    waveAnimation = Tween(begin: 0.0, end: 0.10).animate(animationWaveController);
    waveAnimation.addListener(() {
      if (waveAnimation.status == AnimationStatus.completed) {
        animationWaveController.reverse();
      } else if (waveAnimation.status == AnimationStatus.dismissed) {
        animationWaveController.forward();
      }
    });
    animationWaveController.forward();
    super.initState();
  }
  @override
  void dispose() {
    animationWaveController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedBuilder(
          animation: animationWaveController,
          builder: (BuildContext context, child){
            return CustomPaint(
              size: MediaQuery.of(context).size,
              painter: _AboutMeBackgroundPainter(primaryColor: widget.waveColor ?? Theme.of(context).primaryColor, waveAnimation: waveAnimation)
            );
          },
        ),
        BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 12.5, sigmaY: 12.5
          ),
          child: Container(
            height: double.infinity,
          ),
        ),
      ],
    );
  }
}

class _AboutMeBackgroundPainter extends CustomPainter{
  final Color primaryColor;
  final Animation waveAnimation;
  _AboutMeBackgroundPainter({
    required this.primaryColor,
    required this.waveAnimation,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final brush             = Paint();
          brush.color       = primaryColor;
          brush.style       = PaintingStyle.fill;
          brush.strokeWidth = 10.0;
    final path = Path();
          path.moveTo(0, size.height * 0.90);
          path.quadraticBezierTo(size.width * 0.25, size.height * (0.85 + waveAnimation.value), size.width * 0.50, size.height * 0.90);
          path.quadraticBezierTo(size.width * 0.75, size.height * (0.95 - waveAnimation.value), size.width, size.height * 0.90);
          path.lineTo(size.width, size.height);
          path.lineTo(0, size.height);

    canvas.drawPath(path, brush);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
  
}