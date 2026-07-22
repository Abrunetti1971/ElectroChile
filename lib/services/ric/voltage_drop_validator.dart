import 'voltage_drop_service.dart';
import 'ric_validation_result.dart';
import 'ric_validator.dart';

class VoltageDropValidator extends RicValidator {
  const VoltageDropValidator();

  final VoltageDropService _service = const VoltageDropService();

  @override
  String get id => 'voltage_drop';

  @override
  String get name => 'Validación RIC 05 - Caída de tensión';

  @override
  Future<List<RicValidationResult>> validate(
      RicValidationContext context,
      ) async {
    final results = <RicValidationResult>[];

    for (final circuit in context.circuits) {
      final result = _service.validate(
        voltage: circuit.voltage,
        current: circuit.current,
        length: circuit.length,
        section: circuit.conductorSection,
        material: circuit.conductorMaterial,
        phases: circuit.phases,
      );

      if (!result.complies) {
        results.add(
          RicValidationResult(
            validatorId: id,
            code: 'RIC05-001',
            title: 'Caída de tensión excesiva',
            message:
            'Circuito ${circuit.number}: ${result.voltageDropPercent.toStringAsFixed(2)} %.',
            recommendation:
            'Aumentar conductor a ${result.recommendedSection.toStringAsFixed(1)} mm².',
            ricReference: 'RIC 05',
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