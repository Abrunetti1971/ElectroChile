import '../models/feeder.dart';
import '../repositories/feeder_repository.dart';

class FeederService {
  final FeederRepository repository;

  FeederService(this.repository);

  Future<List<Feeder>> getFeeders(
    String projectId,
  ) async {
    return repository.getByProject(projectId);
  }

  Future<Feeder?> getFeeder(
    String id,
  ) async {
    return repository.getById(id);
  }

  Future<void> addFeeder(
    Feeder feeder,
  ) async {
    await repository.add(feeder);
  }

  Future<void> updateFeeder(
    Feeder feeder,
  ) async {
    await repository.update(feeder);
  }

  Future<void> deleteFeeder(
    String id,
  ) async {
    await repository.delete(id);
  }

  Future<int> nextNumber(
    String projectId,
  ) async {
    return repository.nextFeederNumber(projectId);
  }

  double calculateCurrent({
    required double power,
    required double voltage,
    int phases = 1,
    double powerFactor = 1.0,
  }) {
    if (voltage <= 0) return 0;

    if (phases == 3) {
      return power / (1.732 * voltage * powerFactor);
    }

    return power / (voltage * powerFactor);
  }

  double calculateDemand({
    required double installedPower,
    required double demandFactor,
  }) {
    return installedPower * demandFactor;
  }

  double calculateVoltageDrop({
    required double current,
    required double length,
    required double resistancePerKm,
    required double voltage,
  }) {
    if (voltage <= 0) return 0;

    final drop = (2 * length * current * resistancePerKm) / 1000;
    return (drop / voltage) * 100;
  }
}
