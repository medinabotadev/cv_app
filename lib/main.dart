import 'package:flutter/material.dart';
import 'route_generator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
        scaffoldBackgroundColor: const Color(0xFFF2F2F2),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0
        ),
        primaryColor: const Color(0xFFAAFF00), 
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: const Color(0xFF006317),
          brightness: Brightness.light
          ),
        dividerColor: Theme.of(context).primaryColor.withOpacity(0.2),
        focusColor: Theme.of(context).primaryColor,
        hintColor: const Color(0xFF474747),
        iconTheme: const IconThemeData(
          size: 30.0,
          color: Color(0xFF474747)
        ),
        textTheme: const TextTheme(
          headline1: TextStyle(
            fontFamily: 'NunitoSans',
            color: Color(0xFF006317),
            fontSize: 65,
            height: 1.0
          ),
          headline2: TextStyle(
            fontFamily: 'NunitoSans',
            color: Color(0xFF006317),
            height: 1.0
          ),
          headline3: TextStyle(
            fontFamily: 'NunitoSans',
            height: 1.0
          ),
          headline4: TextStyle(
            fontFamily: 'NunitoSans',
            fontWeight: FontWeight.w700,
            height: 1.4
          ),
          headline5: TextStyle(
            fontFamily: 'NunitoSans',
            height: 1.0,
            letterSpacing: 2,
            color: Color(0XFF1C1C1C)
          ),
          headline6: TextStyle(
            fontFamily: 'NunitoSans',
            fontWeight: FontWeight.w900,
            height: 1.0
          ),
          subtitle1: TextStyle(
            fontFamily: 'NunitoSans',
            height: 1.3,
            color: Color(0xFF474747)
          ),
          subtitle2: TextStyle(
            fontFamily: 'NunitoSans',
            height: 1.4,
            fontSize: 16.0
          )
        )
      ),
      darkTheme: ThemeData(
        // brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0XFF1C1C1C),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0
        ),
        primaryColor: const Color(0xFFAAFF00),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: const Color(0xFF006317),
          brightness: Brightness.dark
          ),
        dividerColor: Theme.of(context).primaryColor.withOpacity(0.2),
        focusColor: Theme.of(context).primaryColor,
        hintColor: const Color(0xFFa8a7a8),
        iconTheme: const IconThemeData(
          size: 30.0,
          color: Color(0xFFa8a7a8)
        ),
        textTheme: const TextTheme(
          headline1: TextStyle(
            fontFamily: 'NunitoSans',
            color: Color(0xFFAAFF00),
            fontSize: 65.0,
            height: 1.0
          ),
          headline2: TextStyle(
            fontFamily: 'NunitoSans',
            color: Color(0xFFAAFF00),
            height: 1.0
          ),
          headline3: TextStyle(
            fontFamily: 'NunitoSans',
            height: 1.0
          ),
          headline4: TextStyle(
            fontFamily: 'NunitoSans',
            color: Color(0xFFFFFFFF),
            fontWeight: FontWeight.w700,
            height: 1.4,
          ),
          headline5: TextStyle(
            fontFamily: 'NunitoSans',
            height: 1.0,
            letterSpacing: 2,
            color: Color(0XFF1C1C1C)
          ),
          headline6: TextStyle(
            fontFamily: 'NunitoSans',
            height: 1.0
          ),
          subtitle1: TextStyle(
            fontFamily: 'NunitoSans',
            height: 1.3,
            color: Color(0xFF474747)
          ),
          subtitle2: TextStyle(
            fontFamily: 'NunitoSans',
            height: 1.4,
            fontSize: 16.0
          )
        )
      ),
      // themeMode: ThemeMode.light,
      // themeMode: ThemeMode.dark,
      themeMode: ThemeMode.system,
      initialRoute: '/SplashScreen',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
