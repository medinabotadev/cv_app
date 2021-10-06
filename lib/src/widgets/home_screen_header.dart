import 'package:flutter/material.dart';

class HomeScreenHeader extends StatefulWidget {
  final Widget child;
  const HomeScreenHeader({ 
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  _HomeScreenHeaderState createState() => _HomeScreenHeaderState();
}

class _HomeScreenHeaderState extends State<HomeScreenHeader> with SingleTickerProviderStateMixin{
  late AnimationController animationController;
  late Animation<double>   moveHeaderRight;
  late Animation<double>   fadeHeaderIn;

  @override
  void initState() {
    animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 4000));
    fadeHeaderIn  = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animationController, curve: const Interval(0.0, 0.25, curve: Curves.easeInOutExpo))
    );
    moveHeaderRight  = Tween(begin: -200.0, end: 0.0).animate(
      CurvedAnimation(parent: animationController, curve: const Interval(0.0, 0.25, curve: Curves.elasticOut))
    );
    super.initState();
  }
  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    animationController.forward();
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, child){
          return Positioned(
          left: moveHeaderRight.value,
          top: 0,
          child: Opacity(
            opacity: 1,
            child: widget.child
          ),
        );
      },
    );
  }
}