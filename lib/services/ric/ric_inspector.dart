import '../../models/circuit.dart';

class RicInspectionResult {
  final bool complies;

  final bool sectionOk;
  final bool breakerOk;
  final bool differentialOk;
  final bool voltageDropOk;
  final bool earthOk;
  final bool conduitOk;

  final List<String> warnings;
  final List<String> errors;

  const RicInspectionResult({
    required this.complies,
    required this.sectionOk,
    required this.breakerOk,
    required this.differentialOk,
    required this.voltageDropOk,
    required this.earthOk,
    required this.conduitOk,
    required this.warnings,
    required this.errors,
  });
}

class RicInspector {
  const RicInspector();

  RicInspectionResult inspect({
    required Circuit circuit,
    required double voltageDrop,
  }) {
    final errors = <String>[];
    final warnings = <String>[];

    //----------------------------------------
    // Sección mínima
    //----------------------------------------

    bool sectionOk = true;

    switch (circuit.type.toLowerCase()) {
      case 'alumbrado':
        sectionOk = circuit.conductorSection >= 1.5;
        break;

      case 'enchufes':
        sectionOk = circuit.conductorSection >= 2.5;
        break;

      default:
        sectionOk = circuit.conductorSection >= 2.5;
    }

    if (!sectionOk) {
      errors.add(
        'La sección del conductor es inferior al mínimo permitido.',
      );
    }

    //----------------------------------------
    // Protección
    //----------------------------------------

    final breaker =
        int.tryParse(
          circuit.protection.split(' ').first,
        ) ??
            0;

    bool breakerOk = true;

    switch (circuit.type.toLowerCase()) {
      case 'alumbrado':
        breakerOk = breaker >= 10;
        break;

      default:
        breakerOk = breaker >= 16;
    }

    if (!breakerOk) {
      errors.add(
        'La protección es inferior al mínimo recomendado.',
      );
    }

    //----------------------------------------
    // Diferencial
    //----------------------------------------

    final differentialOk =
    circuit.differential.contains('30');

    if (!differentialOk) {
      warnings.add(
        'Se recomienda diferencial de 30 mA.',
      );
    }

    //----------------------------------------
    // Caída de tensión
    //----------------------------------------

    final voltageDropOk =
        voltageDrop <= 3;

    if (!voltageDropOk) {
      errors.add(
          'La caída de tensión supera el 3 %.'
      );
    }

    //----------------------------------------
    // Tierra
    //----------------------------------------

    final earthOk =
        circuit.earth.isNotEmpty;

    if (!earthOk) {
      warnings.add(
        'No existe conductor de protección definido.',
      );
    }

    //----------------------------------------
    // Canalización
    //----------------------------------------

    final conduitOk =
        circuit.conduit.isNotEmpty;

    if (!conduitOk) {
      warnings.add(
        'Debe definir una canalización.',
      );
    }

    //----------------------------------------

    final complies =
        errors.isEmpty;

    return RicInspectionResult(
      complies: complies,
      sectionOk: sectionOk,
      breakerOk: breakerOk,
      differentialOk: differentialOk,
      voltageDropOk: voltageDropOk,
      earthOk: earthOk,
      conduitOk: conduitOk,
      warnings: warnings,
      errors: errors,
    );
  }
}