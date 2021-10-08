import '../models/user.dart';

import '../models/section.dart';

class HomeScreenProvider{
  List<Section> getSections() {
    List<Section> sections = [];
    SectionList _sectionList = SectionList();
    for (var element in _sectionList.sectionList) {
      sections.add(element);
    }
    return sections;
  }

  User getMainUser(){
    User _user = User();
    _user = _user.listenMainUser();
    return _user;
  }
}