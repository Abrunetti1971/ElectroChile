import 'ric_rules.dart';
import 'ric_validation_result.dart';
import 'ric_validator.dart';

class RicConductorsValidator extends RicValidator {
  const RicConductorsValidator();

  @override
  String get id => 'conductors';

  @override
  String get name => 'Conductores';

  @override
  Future<List<RicValidationResult>> validate(
      RicValidationContext context,
      ) async {
    final results = <RicValidationResult>[];

    for (final circuit in context.circuits) {
      final minimumSection =
      RicRules.minimumSection(circuit.type);

      if (circuit.conductorSection < minimumSection) {
        results.add(
          RicValidationResult(
            validatorId: id,
            code: 'RIC04-001',
            title: 'Sección insuficiente',
            message:
            'Circuito ${circuit.number}: ${circuit.name} utiliza ${circuit.conductorSection.toStringAsFixed(1)} mm².',
            recommendation:
            'Utilice una sección mínima de ${minimumSection.toStringAsFixed(1)} mm².',
            ricReference: 'RIC-04',
            severity: RicSeverity.error,
            circuitId: circuit.id,
            circuitNumber: circuit.number,
          ),
        );
      }

      if (!RicRules.standardSections.contains(
        circuit.conductorSection,
      )) {
        results.add(
          RicValidationResult(
            validatorId: id,
            code: 'RIC04-002',
            title: 'Sección no normalizada',
            message:
            'Circuito ${circuit.number}: ${circuit.conductorSection} mm² no corresponde a una sección comercial normalizada.',
            recommendation:
            'Seleccione una sección normalizada.',
            ricReference: 'RIC-04',
            severity: RicSeverity.warning,
            circuitId: circuit.id,
            circuitNumber: circuit.number,
          ),
        );
      }

      if (circuit.conductorMaterial.trim().isEmpty) {
        results.add(
          RicValidationResult(
            validatorId: id,
            code: 'RIC04-003',
            title: 'Material no definido',
            message:
            'Circuito ${circuit.number}: no tiene definido el material del conductor.',
            recommendation:
            'Especifique Cobre o Aluminio.',
            ricReference: 'RIC-04',
            severity: RicSeverity.warning,
            circuitId: circuit.id,
            circuitNumber: circuit.number,
          ),
        );
      }

      if (circuit.conductorMaterial.toLowerCase() != 'cobre' &&
          circuit.conductorMaterial.toLowerCase() != 'aluminio') {
        results.add(
          RicValidationResult(
            validatorId: id,
            code: 'RIC04-004',
            title: 'Material inválido',
            message:
            'Circuito ${circuit.number}: "${circuit.conductorMaterial}" no corresponde a un material válido.',
            recommendation:
            'Utilice "Cobre" o "Aluminio".',
            ricReference: 'RIC-04',
            severity: RicSeverity.warning,
            circuitId: circuit.id,
            circuitNumber: circuit.number,
          ),
        );
      }
    }

    return results;
  }
}