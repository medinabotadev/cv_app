import 'package:flutter/material.dart';
import '../models/section.dart';
import 'about_me_screen.dart';
import 'work_experience_screen.dart';
import 'under_construction_screen.dart';

class SectionScreen extends StatefulWidget {
  final Section section;
  const SectionScreen({
    Key? key,
    required this.section
  }) : super(key: key);

  @override
  _SectionScreenState createState() => _SectionScreenState();
}

class _SectionScreenState extends State<SectionScreen> {
  late Section section;
  @override
  void initState() {
    section = widget.section;
    super.initState();
  }

  Widget _section(String _sectionName){
    switch (_sectionName) {
      case '/AboutMe':
        return AboutMe(heroTag: section.argument);
      case '/WorkExperience':
        return WorkExperienceScreen(heroTag: section.argument);
      default:
        return const UnderConstruction();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _section(section.argument)
    );
  }
}