import 'package:flutter/material.dart';
import 'package:my_cv_app/src/widgets/about_me_background.dart';

class WorkExperienceScreen extends StatefulWidget {
  final String heroTag;
  const WorkExperienceScreen({ Key? key, required this.heroTag }) : super(key: key);

  @override
  _WorkExperienceScreenState createState() => _WorkExperienceScreenState();
}

class _WorkExperienceScreenState extends State<WorkExperienceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: const <Widget>[
          SectionsBackground()
        ],
      ),
    );
  }
}