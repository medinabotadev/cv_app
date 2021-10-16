import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import '../widgets/home_screen_end_drawer.dart';
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
  final _drawerController = ZoomDrawerController();
  bool isDrawerOpen = false;
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
            child: Builder(
              builder: (context) => IconButton(
                icon: isDrawerOpen ? const Icon(Icons.close) : const Icon(Icons.menu), 
                color: Theme.of(context).iconTheme.color,
                iconSize: Theme.of(context).iconTheme.size!,
                onPressed: (){ 
                    // Scaffold.of(context).openEndDrawer();
                    if (_drawerController.stateNotifier!.value == DrawerState.closed) {
                      isDrawerOpen = true;
                      _drawerController.open!();
                    } else if (_drawerController.stateNotifier!.value == DrawerState.open) {
                      isDrawerOpen = false;
                      _drawerController.close!();
                    }
                    // TODO: Best management of app state
                    setState(() {});
                  }
                ),
            ),
          )
        ]
      ),
      body: ZoomDrawer(
        controller: _drawerController,
        disableGesture: true,
        menuScreen: const EndDrawer(),
        mainScreen: Stack(
          children: <Widget>[
            const HomeScreenBackground(),
            HomeScreenHeader(
              child: Container(
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
            )
          ],
        ),
      )
    );
  }
}