import '../models/circuit.dart';

class CircuitRepository {
  final List<Circuit> _circuits = [];

  List<Circuit> getAll() {
    return List.unmodifiable(_circuits);
  }

  List<Circuit> getByProject(String projectId) {
    return _circuits
        .where((circuit) => circuit.projectId == projectId)
        .toList();
  }

  Circuit? getById(String id) {
    try {
      return _circuits.firstWhere(
            (circuit) => circuit.id == id,
      );
    } catch (_) {
      return null;
    }
  }

  void add(Circuit circuit) {
    _circuits.add(circuit);
  }

  bool update(Circuit circuit) {
    final index = _circuits.indexWhere(
          (item) => item.id == circuit.id,
    );

    if (index == -1) {
      return false;
    }

    _circuits[index] = circuit;
    return true;
  }

  bool delete(String id) {
    final before = _circuits.length;

    _circuits.removeWhere(
          (circuit) => circuit.id == id,
    );

    return before != _circuits.length;
  }

  void deleteByProject(String projectId) {
    _circuits.removeWhere(
          (circuit) => circuit.projectId == projectId,
    );
  }

  int countByProject(String projectId) {
    return _circuits
        .where((circuit) => circuit.projectId == projectId)
        .length;
  }

  void clear() {
    _circuits.clear();
  }

  bool get isEmpty => _circuits.isEmpty;

  bool get isNotEmpty => _circuits.isNotEmpty;
}