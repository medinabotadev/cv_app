import 'dart:async';

import 'package:flutter/material.dart';

class SplashProvider{
  void navigateToHome(BuildContext context){
    Timer(const Duration(milliseconds: 4000), () {
      Navigator.pushNamedAndRemoveUntil( context, '/HomeScreen', (route) => false);
    });
  }
}
