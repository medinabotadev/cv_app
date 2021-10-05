import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:my_cv_app/src/widgets/home_screen_header.dart';
import '../widgets/home_screen_background.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: IconButton(
              icon: const Icon(Icons.menu), 
              color: Theme.of(context).iconTheme.color,
              iconSize: Theme.of(context).iconTheme.size!,
              onPressed: (){}
              ),
          )
        ]
      ),
      body: Stack(
        children: <Widget>[
          const HomeScreenBackground(),
          HomeScreenHeader(
            child: Container(
              width: 315.0,
              height: 350.0,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.only(bottomRight: Radius.circular(70)),
                boxShadow: [
                  BoxShadow(
                      color: Theme.of(context).primaryColor.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 10,
                      offset: const Offset(0, 2)),
                ],
              ),
            ),
          )
        ],
      )
    );
  }
}