import '../../models/circuit.dart';
import '../../models/sec/sec_validation.dart';
import 'sec_rules.dart';

class RicValidationService {
  const RicValidationService();

  List<SecValidation> validate(List<Circuit> circuits) {
    final validations = <SecValidation>[];

    if (circuits.isEmpty) {
      validations.add(
        SecRules.projectWithoutCircuits(),
      );

      return validations;
    }

    for (final circuit in circuits) {
      if (circuit.power <= 0) {
        validations.add(
          SecRules.invalidPower(circuit.name),
        );
      }

      if (circuit.length <= 0) {
        validations.add(
          SecRules.missingLength(circuit.name),
        );
      }

      if (circuit.conductorSection <= 0) {
        validations.add(
          SecRules.invalidSection(circuit.name),
        );
      }

      if (circuit.conductorMaterial.trim().isEmpty) {
        validations.add(
          SecRules.missingMaterial(circuit.name),
        );
      }

      if (circuit.protection.trim().isEmpty) {
        validations.add(
          SecRules.missingProtection(circuit.name),
        );
      }
    }

    if (validations.isEmpty) {
      validations.add(
        SecRules.projectOk(),
      );
    }

    return validations;
  }
}