import 'package:flutter/material.dart';
import 'routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jesús Medina',
      theme: ThemeData(
        // brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF2F2F2),
        primaryColor: const Color(0xFFAAFF00), 
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: const Color(0xFF006317),
          brightness: Brightness.light
          ),
        dividerColor: Theme.of(context).primaryColor.withOpacity(0.2),
        focusColor: Theme.of(context).primaryColor,
        hintColor: Theme.of(context).colorScheme.secondary,
        textTheme: const TextTheme(
          headline1: TextStyle(
            fontFamily: 'NunitoSans',
            color: Color(0xFFAAFF00),
            height: 1.0
          ),
          headline2: TextStyle(
            fontFamily: 'NunitoSans',
            color: Color(0xFFAAFF00),
            height: 1.0
          ),
        )
      ),
      darkTheme: ThemeData(
        // brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0XFF1C1C1C),
        primaryColor: const Color(0xFFAAFF00),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: const Color(0xFF006317),
          brightness: Brightness.dark
          ),
        dividerColor: Theme.of(context).primaryColor.withOpacity(0.2),
        focusColor: Theme.of(context).primaryColor,
        hintColor: Theme.of(context).colorScheme.secondary,
        textTheme: const TextTheme(
          headline1: TextStyle(
            fontFamily: 'NunitoSans',
            color: Color(0xFFAAFF00),
            height: 1.0
          ),
          headline2: TextStyle(
            fontFamily: 'NunitoSans',
            color: Color(0xFFAAFF00),
            height: 1.0
          ),
        )
      ),
      themeMode: ThemeMode.system,
      initialRoute: '/SplashScreen',
      routes: getRoutes(context),
    );
  }
}
