import '../models/circuit.dart';
import '../repositories/circuit_repository.dart';

class CircuitService {
  final CircuitRepository _repository;

  CircuitService(this._repository);

  List<Circuit> getCircuits(String projectId) {
    return _repository.getByProject(projectId);
  }

  Circuit? getCircuit(String id) {
    return _repository.getById(id);
  }

  void createCircuit({
    required String id,
    required String projectId,
    required String name,
    required CircuitType type,
    required double voltage,
    required double power,
    required double length,
    String conductor = '',
    String breaker = '',
    String differential = '',
    String observations = '',
  }) {
    final double current =
    voltage > 0 ? (power / voltage).toDouble() : 0.0;

    final circuit = Circuit(
      id: id,
      projectId: projectId,
      name: name,
      type: type,
      voltage: voltage,
      power: power,
      current: current,
      length: length,
      conductor: conductor,
      breaker: breaker,
      differential: differential,
      voltageDrop: 0.0,
      observations: observations,
    );

    _repository.add(circuit);
  }

  bool updateCircuit(Circuit circuit) {
    return _repository.update(circuit);
  }

  bool deleteCircuit(String id) {
    return _repository.delete(id);
  }

  int countCircuits(String projectId) {
    return _repository.countByProject(projectId);
  }
}