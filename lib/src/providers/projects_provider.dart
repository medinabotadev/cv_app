import '../models/project.dart';

class ProjectsProvider{
  List<Project> getProjects() {
    List<Project> projectList = [];
    ProjectList _projectList = ProjectList();
    for (var element in _projectList.projectList) {
      projectList.add(element);
    }
    return projectList;
  }
}