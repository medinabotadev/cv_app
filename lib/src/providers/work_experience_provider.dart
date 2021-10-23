import '../models/work_experience.dart';

class WorkExperienceProvider{
  List<WorkExperience> getWorkExperience() {
    List<WorkExperience> workExperienceList = [];
    WorkExperienceList _workExperienceList = WorkExperienceList();
    for (var element in _workExperienceList.workExperienceList) {
      workExperienceList.add(element);
    }
    return workExperienceList;
  }
}