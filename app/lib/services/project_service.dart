import '../models/project.dart';
import '../repositories/project_repository.dart';

class ProjectService {
  final ProjectRepository _repository;

  ProjectService(this._repository);

  List<Project> getProjects() {
    return _repository.getAll();
  }

  Project createProject({
    required String name,
    required String client,
    required String address,
  }) {
    final project = Project(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name.trim(),
      client: client.trim(),
      address: address.trim(),
      createdAt: DateTime.now(),
    );

    _repository.add(project);

    return project;
  }

  void deleteProject(String id) {
    _repository.remove(id);
  }

  Project? getProject(String id) {
    return _repository.getById(id);
  }

  void updateProject(Project project) {
    _repository.update(project);
  }

  int get totalProjects => _repository.count;

  bool get hasProjects => !_repository.isEmpty;
}