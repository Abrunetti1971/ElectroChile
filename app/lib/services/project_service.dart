import '../models/project.dart';
import '../repositories/project_repository.dart';

class ProjectService {
  final ProjectRepository _repository;

  ProjectService(this._repository);

  List<Project> getProjects() {
    _repository.sortByDate();
    return _repository.getAll();
  }

  Project createProject({
    required String name,
    required String client,
    required String address,
    String city = '',
    String region = '',
  }) {
    final projectName = name.trim();

    if (projectName.isEmpty) {
      throw Exception('El nombre del proyecto es obligatorio.');
    }

    if (_repository.existsByName(projectName)) {
      throw Exception('Ya existe un proyecto con ese nombre.');
    }

    final now = DateTime.now();

    final project = Project(
      id: now.microsecondsSinceEpoch.toString(),
      name: projectName,
      client: client.trim(),
      address: address.trim(),
      city: city.trim(),
      region: region.trim(),
      createdAt: now,
      updatedAt: now,
    );

    _repository.add(project);

    return project;
  }

  bool deleteProject(String id) {
    return _repository.delete(id);
  }

  bool updateProject(Project project) {
    return _repository.update(
      project.copyWith(
        updatedAt: DateTime.now(),
      ),
    );
  }

  Project? getProject(String id) {
    return _repository.getById(id);
  }

  int get totalProjects => _repository.count;

  bool get hasProjects => _repository.isNotEmpty;
}