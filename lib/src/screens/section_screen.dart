import 'package:flutter/material.dart';
import '../models/section.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(section.name),
      ),
    );
  }
}