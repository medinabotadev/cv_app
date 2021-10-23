import 'package:flutter/material.dart';

class WorkExperience{
  late String period;
  late String companyName;
  late String description;

  WorkExperience({required this.period, required this.companyName, required this.description});

  WorkExperience.fromJson(Map<String, dynamic> jsonMap){
    try {
      period      = jsonMap['period'] ?? '';
      companyName = jsonMap['companyName'] ?? '';
      description = jsonMap['description'] ?? '';
    } catch (e) {
      debugPrint('Work Experience model: ' + e.toString());
    }
  }
}

class WorkExperienceList{
  List<WorkExperience> _workExperienceList = [];

  WorkExperienceList(){
    _workExperienceList = [
      WorkExperience(period: 'JAN/2021 - Present', companyName: 'Softandnet, Compañia Anonima', description: 'App development'),
      WorkExperience(period: 'JAN/2021 - Present', companyName: 'Detodito, LLC', description: 'App development'),
    ];
  }

  List<WorkExperience> get workExperienceList => _workExperienceList;
}