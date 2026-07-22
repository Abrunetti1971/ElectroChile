import 'ric_rules.dart';
import 'ric_validation_result.dart';
import 'ric_validator.dart';

class RicProtectionsValidator extends RicValidator {
  const RicProtectionsValidator();

  @override
  String get id => 'protections';

  @override
  String get name => 'Protecciones';

  @override
  Future<List<RicValidationResult>> validate(
      RicValidationContext context,
      ) async {
    final results = <RicValidationResult>[];

    for (final circuit in context.circuits) {
      final breaker =
          int.tryParse(circuit.protection.split(' ').first) ?? 0;

      final minimumBreaker =
      RicRules.minimumProtection(circuit.type);

      if (breaker < minimumBreaker) {
        results.add(
          RicValidationResult(
            validatorId: id,
            code: 'RIC06-001',
            title: 'Protección insuficiente',
            message:
            'Circuito ${circuit.number}: ${circuit.name} utiliza un interruptor automático de $breaker A.',
            recommendation:
            'Utilice una protección mínima de $minimumBreaker A.',
            ricReference: 'RIC-06',
            severity: RicSeverity.error,
            circuitId: circuit.id,
            circuitNumber: circuit.number,
          ),
        );
      }

      if (breaker <= 0) {
        results.add(
          RicValidationResult(
            validatorId: id,
            code: 'RIC06-002',
            title: 'Protección no definida',
            message:
            'Circuito ${circuit.number}: ${circuit.name} no posee un interruptor automático válido.',
            recommendation:
            'Defina la protección del circuito.',
            ricReference: 'RIC-06',
            severity: RicSeverity.error,
            circuitId: circuit.id,
            circuitNumber: circuit.number,
          ),
        );
      }

      if (circuit.differential.trim().isEmpty) {
        results.add(
          RicValidationResult(
            validatorId: id,
            code: 'RIC09-001',
            title: 'Diferencial no definido',
            message:
            'Circuito ${circuit.number}: ${circuit.name} no tiene interruptor diferencial asignado.',
            recommendation:
            'Defina un interruptor diferencial de ${RicRules.differentialSensitivity} mA cuando corresponda.',
            ricReference: 'RIC-09',
            severity: RicSeverity.warning,
            circuitId: circuit.id,
            circuitNumber: circuit.number,
          ),
        );
      }

      if (circuit.protection.trim().isEmpty) {
        results.add(
          RicValidationResult(
            validatorId: id,
            code: 'RIC06-003',
            title: 'Campo protección vacío',
            message:
            'Circuito ${circuit.number}: ${circuit.name} no tiene información de protección.',
            recommendation:
            'Ingrese el interruptor automático del circuito.',
            ricReference: 'RIC-06',
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