import '../../models/sec/sec_validation.dart';

/// Biblioteca oficial de reglas SEC / RIC.
///
/// Todas las validaciones del sistema deben construirse desde aquí.
/// Esto evita textos duplicados y facilita futuras modificaciones.
class SecRules {
  SecRules._();

  static SecValidation projectWithoutCircuits() {
    return const SecValidation(
      code: 'PROJECT-001',
      title: 'Proyecto sin circuitos',
      description:
      'El proyecto no contiene circuitos eléctricos registrados.',
      recommendation:
      'Agregue al menos un circuito antes de continuar.',
      regulation: 'General',
      status: SecValidationStatus.failed,
    );
  }

  static SecValidation invalidPower(String circuitName) {
    return SecValidation(
      code: 'RIC-LOAD-001',
      title: 'Potencia inválida',
      description:
      'El circuito "$circuitName" posee una potencia igual o menor que cero.',
      recommendation:
      'Ingrese una potencia instalada válida.',
      regulation: 'RIC 10',
      status: SecValidationStatus.warning,
    );
  }

  static SecValidation missingLength(String circuitName) {
    return SecValidation(
      code: 'RIC-COND-001',
      title: 'Longitud no definida',
      description:
      'El circuito "$circuitName" no posee longitud registrada.',
      recommendation:
      'Ingrese la longitud para calcular la caída de tensión.',
      regulation: 'RIC 06',
      status: SecValidationStatus.warning,
    );
  }

  static SecValidation invalidSection(String circuitName) {
    return SecValidation(
      code: 'RIC-COND-002',
      title: 'Sección del conductor inválida',
      description:
      'La sección del conductor del circuito "$circuitName" no es válida.',
      recommendation:
      'Seleccione una sección normalizada.',
      regulation: 'RIC 06',
      status: SecValidationStatus.failed,
    );
  }

  static SecValidation missingMaterial(String circuitName) {
    return SecValidation(
      code: 'RIC-COND-003',
      title: 'Material del conductor',
      description:
      'No se indicó el material del conductor del circuito "$circuitName".',
      recommendation:
      'Seleccione cobre o aluminio.',
      regulation: 'RIC 06',
      status: SecValidationStatus.warning,
    );
  }

  static SecValidation missingProtection(String circuitName) {
    return SecValidation(
      code: 'RIC-PROT-001',
      title: 'Protección no definida',
      description:
      'El circuito "$circuitName" no posee protección asignada.',
      recommendation:
      'Seleccione un interruptor automático adecuado.',
      regulation: 'RIC 09',
      status: SecValidationStatus.failed,
    );
  }

  static SecValidation projectOk() {
    return const SecValidation(
      code: 'PROJECT-OK',
      title: 'Proyecto validado',
      description:
      'No se encontraron observaciones técnicas.',
      recommendation:
      'El proyecto está listo para continuar.',
      regulation: 'General',
      status: SecValidationStatus.passed,
    );
  }
}