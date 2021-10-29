class Section{
  String name;
  String argument;

  Section({
    required this.name,
    required this.argument
  });
}

class SectionList{
  List<Section> _sectionList = [];

  SectionList(){
    _sectionList = [
      Section(name: 'About Me',        argument: '/AboutMe'),
      Section(name: 'Work Experience', argument: '/WorkExperience'),
      Section(name: 'Projects',        argument: '/Projects'),
      Section(name: 'Education',       argument: '/Education'),
      Section(name: 'Contact',         argument: '/Contact'),
    ];
  }

  List<Section> get sectionList => _sectionList;
}