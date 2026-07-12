import '../models/project.dart';

class ProjectRepository {
  final List<Project> _projects = [];

  List<Project> getAll() {
    return List.unmodifiable(_projects);
  }

  void add(Project project) {
    _projects.add(project);
  }

  void remove(String id) {
    _projects.removeWhere((project) => project.id == id);
  }

  void update(Project project) {
    final index = _projects.indexWhere(
          (item) => item.id == project.id,
    );

    if (index != -1) {
      _projects[index] = project;
    }
  }

  Project? getById(String id) {
    try {
      return _projects.firstWhere(
            (project) => project.id == id,
      );
    } catch (_) {
      return null;
    }
  }

  bool get isEmpty => _projects.isEmpty;

  int get count => _projects.length;

  void clear() {
    _projects.clear();
  }
}