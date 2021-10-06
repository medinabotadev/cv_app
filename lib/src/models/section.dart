// ignore_for_file: non_constant_identifier_names

class Section{
  String name   = '';
  String route  = '';

  Section({
    required this.name,
    required this.route
  });
}

class SectionList{
  List<Section> _sectionList = [];

  SectionList(){
    _sectionList = [
      Section(name: 'About Me',        route: '/AboutMe'),
      Section(name: 'Work Experience', route: '/WorkExperience'),
      Section(name: 'Projects',        route: '/Projects'),
      Section(name: 'Education',       route: '/Education'),
      Section(name: 'Contact',         route: '/Contact'),
    ];
  }

  List<Section> get sectionList => _sectionList;
}