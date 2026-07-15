import '../models/project.dart';
import '../repositories/project_repository.dart';

class ProjectService {
  final ProjectRepository repository;

  ProjectService(this.repository);

  List<Project> getProjects() {
    return repository.getAll();
  }

  Project createProject({
    required String name,
    required String client,
    required String address,
    required String city,
  }) {
    final project = Project(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      client: client,
      address: address,
      city: city,
      createdAt: DateTime.now(),
    );

    repository.add(project);

    return project;
  }

  bool deleteProject(String id) {
    return repository.delete(id);
  }

  bool updateProject(Project project) {
    return repository.update(project);
  }

  Project? getProject(String id) {
    return repository.getById(id);
  }

  List<Project> searchProjects(String text) {
    return repository.search(text);
  }
}