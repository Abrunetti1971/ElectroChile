import '../../models/circuit.dart';
import '../../models/project.dart';
import 'ric_registry.dart';
import 'ric_validation_result.dart';
import 'ric_validator.dart';

class RicEngine {
  final RicRegistry registry;

  const RicEngine({
    required this.registry,
  });

  Future<RicValidationReport> validateProject({
    required Project project,
    required List<Circuit> circuits,
  }) async {
    final context = RicValidationContext(
      project: project,
      circuits: circuits,
    );

    final results = <RicValidationResult>[];
    var executed = 0;
    var failed = 0;

    for (final validator in registry.validators) {
      if (!validator.supports(context)) {
        continue;
      }

      executed++;

      try {
        final validatorResults = await validator.validate(context);

        for (final result in validatorResults) {
          results.add(
            result.validatorId.isEmpty
                ? result.copyWith(validatorId: validator.id)
                : result,
          );
        }
      } catch (error) {
        failed++;

        results.add(
          RicValidationResult(
            validatorId: validator.id,
            code: 'ENGINE_VALIDATOR_FAILURE',
            title: 'No fue posible ejecutar una validación',
            message:
                'El validador "${validator.name}" produjo un error interno: '
                '$error',
            recommendation:
                'Revisar los datos del proyecto y registrar el error '
                'antes de continuar con la declaración.',
            severity: RicSeverity.error,
          ),
        );
      }
    }

    return RicValidationReport(
      generatedAt: DateTime.now(),
      results: results,
      validatorsExecuted: executed,
      validatorsFailed: failed,
    );
  }
}
