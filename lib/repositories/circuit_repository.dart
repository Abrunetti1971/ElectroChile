import '../database/circuit_dao.dart';
import '../models/circuit.dart';

class CircuitRepository {
  CircuitRepository();

  final CircuitDao _dao = CircuitDao.instance;

  Future<List<Circuit>> getByProject(
      String projectId,
      ) async {
    return await _dao.getByProject(projectId);
  }

  Future<void> add(
      Circuit circuit,
      ) async {
    await _dao.insert(circuit);
  }

  Future<void> update(
      Circuit circuit,
      ) async {
    await _dao.update(circuit);
  }

  Future<void> delete(
      String id,
      ) async {
    await _dao.delete(id);
  }
}