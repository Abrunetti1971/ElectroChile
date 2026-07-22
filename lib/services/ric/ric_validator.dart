import '../../models/circuit.dart';
import '../../models/project.dart';
import 'ric_validation_result.dart';

class RicValidationContext {
  final Project project;
  final List<Circuit> circuits;

  RicValidationContext({
    required this.project,
    required List<Circuit> circuits,
  }) : circuits = List.unmodifiable(circuits);

  bool get hasCircuits => circuits.isNotEmpty;
  int get circuitCount => circuits.length;

  Circuit? circuitById(String circuitId) {
    for (final circuit in circuits) {
      if (circuit.id == circuitId) {
        return circuit;
      }
    }

    return null;
  }
}

abstract class RicValidator {
  const RicValidator();

  String get id;
  String get name;

  bool supports(RicValidationContext context) => true;

  Future<List<RicValidationResult>> validate(
    RicValidationContext context,
  );
}
