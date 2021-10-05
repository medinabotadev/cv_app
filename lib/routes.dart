import 'package:flutter/cupertino.dart';

import 'src/screens/splash_screen.dart';
import 'src/screens/home_screen.dart';

Map<String, WidgetBuilder> getRoutes(context){
  return{
    '/SplashScreen' : (context) => const SplashScreen(),
    '/HomeScreen'         : (context) => const HomeScreen()
  };
}