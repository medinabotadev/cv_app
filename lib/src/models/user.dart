import 'package:flutter/material.dart';

class User {
  late String name;
  late String lastName;
  String?     occupation;
  String?     description;
  String?     photoUrl;
  String?     bioSection1;
  String?     bioSection2;
  String?     bioSection3;

  User();

  User.fromJson(Map<String, dynamic> jsonMap){
    try {
      name        = jsonMap['name']         ?? '';
      lastName    = jsonMap['lastName']     ?? '';
      occupation  = jsonMap['occupation']   ?? '';
      photoUrl    = jsonMap['photoUrl']     ?? '';
      description = jsonMap['description']  ?? '';
      bioSection1 = jsonMap['bioSection1']  ?? '';
      bioSection2 = jsonMap['bioSection2']  ?? '';
      bioSection3 = jsonMap['bioSection3']  ?? '';
    } catch (e) {
      debugPrint('User model: ' + e.toString());
    }
  }

  String getInitials(){
    return name.split('')[0] + lastName.split('')[0];
  }

  User listenMainUser(){
    return User.fromJson({
      'name'              : 'Jesus',
      'lastName'          : 'Medina',
      'occupation'        : 'Flutter Developer',
      'photoUrl'          : 'https://avatars.githubusercontent.com/u/63433433?s=400&u=9b658c6b3ba9d96b76381f72bc80f82262e3e0da&v=4',
      'backgroundPhotoUrl': 'https://avatars.githubusercontent.com/u/63433433?s=400&u=9b658c6b3ba9d96b76381f72bc80f82262e3e0da&v=4',
      'description'       : 'Wellness to keep learning and growing personaly and profesionally',
      'bioSection1'       : 'Duis eget justo mi. In et tincidunt nibh. Praesent et justo sed enim rutrum vulputate. Nunc quis ante commodo sapien congue suscipit. Vivamus nec condimentum sapien.',
      'bioSection2'       : 'Duis eget justo mi. In et tincidunt nibh. Praesent et justo sed enim rutrum vulputate. Nunc quis ante commodo sapien congue suscipit. Vivamus nec condimentum sapien. Quisque sit amet sapien a orci suscipit semper ac eget orci. Nulla facilisi. Nunc et tortor mi. Praesent sodales aliquet lorem.',
      'bioSection3'       : 'Duis eget justo mi. In et tincidunt nibh. Praesent et justo sed enim rutrum vulputate. Nunc quis ante commodo sapien congue suscipit. Vivamus nec condimentum sapien. Quisque sit amet sapien a orci suscipit semper ac eget orci. Nulla facilisi. Nunc et tortor mi. Praesent sodales aliquet lorem.'
    });
  }
}