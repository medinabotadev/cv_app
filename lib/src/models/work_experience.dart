import 'package:flutter/material.dart';

class WorkExperience{
  late String period;
  late String companyName;
  late String description;
  late String location;

  WorkExperience({required this.period, required this.companyName, required this.description, required this.location});

  WorkExperience.fromJson(Map<String, dynamic> jsonMap){
    try {
      period      = jsonMap['period'] ?? '';
      companyName = jsonMap['companyName'] ?? '';
      description = jsonMap['description'] ?? '';
      location    = jsonMap['location'] ?? '';
    } catch (e) {
      debugPrint('Work Experience model: ' + e.toString());
    }
  }
}

class WorkExperienceList{
  List<WorkExperience> _workExperienceList = [];

  WorkExperienceList(){
    _workExperienceList = [
      WorkExperience(period: 'Jan/2021 - Present', companyName: 'Softandnet', description: 'Software Developer', location: 'Lecheria, Venezuela'),
      WorkExperience(period: 'Jan/2021 - Present', companyName: 'Detodito, LLC', description: 'Mobile Developer', location: 'Lecheria, Venezuela'),
    ];
  }

  List<WorkExperience> get workExperienceList => _workExperienceList;
}