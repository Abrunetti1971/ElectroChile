import '../models/circuit.dart';
import '../repositories/circuit_repository.dart';

class CircuitService {
  final CircuitRepository repository;

  CircuitService(this.repository);

  Future<List<Circuit>> getCircuits(
      String projectId,
      ) async {
    return repository.getByProject(projectId);
  }

  Future<void> addCircuit(
      Circuit circuit,
      ) async {
    await repository.add(circuit);
  }

  Future<void> updateCircuit(
      Circuit circuit,
      ) async {
    await repository.update(circuit);
  }

  Future<void> deleteCircuit(
      String id,
      ) async {
    await repository.delete(id);
  }

  double calculateCurrent({
    required double power,
    required double voltage,
  }) {
    if (voltage == 0) return 0;

    return power / voltage;
  }
}