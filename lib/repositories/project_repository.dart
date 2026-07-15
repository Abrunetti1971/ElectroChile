import '../database/project_dao.dart';
import '../models/project.dart';

class ProjectRepository {
  ProjectRepository();

  final ProjectDao _dao = ProjectDao.instance;

  Future<List<Project>> getAll() async {
    return await _dao.getAll();
  }

  Future<Project?> getById(String id) async {
    return await _dao.getById(id);
  }

  Future<void> add(Project project) async {
    await _dao.insert(project);
  }

  Future<void> update(Project project) async {
    await _dao.update(project);
  }

  Future<void> delete(String id) async {
    await _dao.delete(id);
  }

  Future<List<Project>> search(String text) async {
    return await _dao.search(text);
  }
}