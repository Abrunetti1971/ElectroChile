import '../models/project.dart';

class ProjectRepository {
  ProjectRepository._();

  static final ProjectRepository instance =
  ProjectRepository._();

  final List<Project> _projects = [];

  List<Project> getAll() {
    return List.unmodifiable(_projects);
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

  void add(Project project) {
    _projects.add(project);
  }

  bool update(Project project) {
    final index = _projects.indexWhere(
          (item) => item.id == project.id,
    );

    if (index == -1) {
      return false;
    }

    _projects[index] = project;
    return true;
  }

  bool delete(String id) {
    final before = _projects.length;

    _projects.removeWhere(
          (project) => project.id == id,
    );

    return before != _projects.length;
  }

  void clear() {
    _projects.clear();
  }

  int get count => _projects.length;

  bool get isEmpty => _projects.isEmpty;

  bool get isNotEmpty => _projects.isNotEmpty;

  bool existsByName(String name) {
    return _projects.any(
          (project) =>
      project.name.trim().toLowerCase() ==
          name.trim().toLowerCase(),
    );
  }

  List<Project> search(String text) {
    final query = text.trim().toLowerCase();

    if (query.isEmpty) {
      return getAll();
    }

    return _projects.where((project) {
      return project.name.toLowerCase().contains(query) ||
          project.client.toLowerCase().contains(query) ||
          project.address.toLowerCase().contains(query) ||
          project.city.toLowerCase().contains(query);
    }).toList();
  }

  void sortByName() {
    _projects.sort(
          (a, b) => a.name.compareTo(b.name),
    );
  }

  void sortByDate() {
    _projects.sort(
          (a, b) => b.createdAt.compareTo(a.createdAt),
    );
  }
}