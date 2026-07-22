import '../engine/circuit_engine.dart';

class InstallationCheckResult {
  final List<String> warnings;
  final List<String> errors;
  final bool complies;

  const InstallationCheckResult({
    required this.warnings,
    required this.errors,
    required this.complies,
  });
}

class InstallationChecker {
  InstallationChecker._();

  static InstallationCheckResult check(
      CircuitEngineResult result,
      ) {
    final warnings = <String>[];
    final errors = <String>[];

    //----------------------------------------------------------
    // Conductor
    //----------------------------------------------------------

    if (!result.conductor.complies) {
      errors.add(
        'La sección del conductor no cumple la caída de tensión.',
      );
    }

    //----------------------------------------------------------
    // Protección
    //----------------------------------------------------------

    if (!result.protection.complies) {
      errors.add(
        'La protección seleccionada no cumple Ib ≤ In ≤ Iz.',
      );
    }

    //----------------------------------------------------------
    // Caída tensión
    //----------------------------------------------------------

    if (result.conductor.voltageDropPercent > 3) {
      errors.add(
        'La caída de tensión supera el 3 % permitido.',
      );
    }

    //----------------------------------------------------------
    // Advertencias
    //----------------------------------------------------------

    if (result.protection.inBreaker >= 63) {
      warnings.add(
        'Verificar poder de corte del interruptor.',
      );
    }

    if (result.conductor.section >= 50) {
      warnings.add(
        'Verificar radio mínimo de curvatura del conductor.',
      );
    }

    return InstallationCheckResult(
      warnings: warnings,
      errors: errors,
      complies: errors.isEmpty,
    );
  }
}