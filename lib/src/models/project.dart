import 'package:flutter/material.dart';

class Project{
  String name;
  String photoUrl;
  Color themeColor;
  bool availableAtPlayStore;
  bool availableAtAppStore;

  Project({
    required this.name,
    required this.photoUrl,
    required this.themeColor,
    required this.availableAtPlayStore,
    required this.availableAtAppStore
  });

  String availability() {
    String _availability = '';
    if (availableAtPlayStore && availableAtAppStore) {
      _availability = 'Available on Google Play & App Store';
    } else if (availableAtPlayStore) {
      _availability = 'Available on Google Play';
    } else if (availableAtAppStore) {
      _availability = 'Available on App Store';
    } else {
      _availability = 'Not available in stores yet';
    }

    return _availability;
  }
}

class ProjectList{
  List<Project> _projectList = [];

  ProjectList(){
    _projectList = [
      Project(name: 'Detodito SuperApp',  photoUrl: 'assets/img/detodito.jpg', themeColor: const Color(0xFFe30e13), availableAtPlayStore: true, availableAtAppStore: true),
      Project(name: 'Detodito Drivers',   photoUrl: 'assets/img/driver.png', themeColor: const Color(0xFF34AF24), availableAtPlayStore: false, availableAtAppStore: true),
      Project(name: 'Detodito Business',  photoUrl: 'assets/img/business.png', themeColor: const Color(0xFFED7432), availableAtPlayStore: true, availableAtAppStore: true),
      Project(name: 'Detodito Taxi',      photoUrl: 'assets/img/taxi.png', themeColor: const Color(0xFFE8C22A), availableAtPlayStore: false, availableAtAppStore: false),
      Project(name: 'Skyshop',            photoUrl: 'assets/img/work_experience.jpg', themeColor: Colors.blueAccent.shade700, availableAtPlayStore: true, availableAtAppStore: false),
    ];
  }

  List<Project> get projectList => _projectList;
}