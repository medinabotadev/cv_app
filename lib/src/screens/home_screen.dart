import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import '../widgets/home_screen_header_elements.dart';
import '../models/user.dart';

import '../widgets/home_screen_section.dart';
import '../models/section.dart';
import '../providers/home_screen_provider.dart';
import '../widgets/home_screen_header.dart';
import '../widgets/home_screen_background.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin{
  HomeScreenProvider homeScreenProvider = HomeScreenProvider();
  List<Section>      sections           = [];
  late User user;
  @override
  void initState() {
    homeScreenProvider.getSections().forEach((Section section){
      sections.add(section);
    });
    user = homeScreenProvider.getMainUser();
    super.initState();
  }
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
              // padding: const EdgeInsets.only(top: 70.0),
              width: 325.0,
              height: 370.0,
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
              child: HomeScreenHeaderElements(user: user),
            ),
          ),
          HomeScreenSection(
            sections: sections,
            // onTap: 
          )
        ],
      )
    );
  }
}