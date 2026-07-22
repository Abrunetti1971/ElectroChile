import '../database/feeder_dao.dart';
import '../models/feeder.dart';

class FeederRepository {
  FeederRepository();

  final FeederDao _dao = FeederDao.instance;

  Future<List<Feeder>> getByProject(
    String projectId,
  ) async {
    return await _dao.getByProject(projectId);
  }

  Future<Feeder?> getById(
    String id,
  ) async {
    return await _dao.getById(id);
  }

  Future<void> add(
    Feeder feeder,
  ) async {
    await _dao.insert(feeder);
  }

  Future<void> update(
    Feeder feeder,
  ) async {
    await _dao.update(feeder);
  }

  Future<void> delete(
    String id,
  ) async {
    await _dao.delete(id);
  }

  Future<int> countByProject(
    String projectId,
  ) async {
    return await _dao.countByProject(projectId);
  }

  Future<int> nextFeederNumber(
    String projectId,
  ) async {
    return await _dao.nextFeederNumber(projectId);
  }
}
