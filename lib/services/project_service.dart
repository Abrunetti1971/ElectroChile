import '../models/project.dart';
import '../repositories/project_repository.dart';

class ProjectService {
  final ProjectRepository repository;

  ProjectService(this.repository);

  Future<List<Project>> getProjects() async {
    return await repository.getAll();
  }

  Future<Project> createProject({
    required String name,
    required String client,
    required String address,
    required String city,
    String region = '',
    String distributor = '',
    String notes = '',
  }) async {
    final now = DateTime.now();

    final project = Project(
      id: now.millisecondsSinceEpoch.toString(),
      name: name,
      client: client,
      address: address,
      city: city,
      region: region,
      distributor: distributor,
      notes: notes,
      createdAt: now,
      updatedAt: now,
    );

    await repository.add(project);

    return project;
  }

  Future<void> updateProject(Project project) async {
    await repository.update(
      project.copyWith(updatedAt: DateTime.now()),
    );
  }

  Future<void> deleteProject(String id) async {
    await repository.delete(id);
  }

  Future<Project?> getProject(String id) async {
    return await repository.getById(id);
  }

  Future<List<Project>> searchProjects(String text) async {
    return await repository.search(text);
  }
}