import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'src/models/section.dart';

import 'src/screens/splash_screen.dart';
import 'src/screens/home_screen.dart';
import 'src/screens/section_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings){
    final args = settings.arguments;
    switch (settings.name) {
      case '/SplashScreen':
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case '/HomeScreen':
        return MaterialPageRoute(builder: (context) => const HomeScreen(),);
      case '/SectionScreen':
        return PageRouteBuilder(
          barrierDismissible: true,
          transitionDuration: const Duration(milliseconds: 1000), 
          reverseTransitionDuration: const Duration(milliseconds: 1000), 
          pageBuilder: (context, animation, secondAnimation) => SectionScreen(section: args as Section ),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
              curve: Curves.linear, parent: animation);
                return FadeTransition(
                  opacity:animation,
                  child: child,
            );
          }
        );
      default:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
    }
  }
}