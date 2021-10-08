import 'package:flutter/material.dart';

class User {
  late String name;
  late String lastName;
  String?     occupation;
  String?     bio;
  String?     photoUrl;

  User();

  User.fromJson(Map<String, dynamic> jsonMap){
    try {
      name        = jsonMap['name']       ?? '';
      lastName    = jsonMap['lastName']   ?? '';
      occupation  = jsonMap['occupation'] ?? '';
      photoUrl    = jsonMap['photoUrl']   ?? '';
      bio         = jsonMap['bio']        ?? '';
    } catch (e) {
      debugPrint('User model: ' + e.toString());
    }
  }

  String getInitials(){
    return name.split('')[0] + lastName.split('')[0];
  }

  User listenMainUser(){
    return User.fromJson({
      'name'        : 'Jesus',
      'lastName'    : 'Medina',
      'occupation'  : 'Flutter Developer',
      'photoUrl'    : 'https://avatars.githubusercontent.com/u/63433433?s=400&u=9b658c6b3ba9d96b76381f72bc80f82262e3e0da&v=4',
      'bio'         : 'Wellness to keep learning and growing personaly and profesionally'
    });
  }
}