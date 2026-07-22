import '../../models/circuit.dart';
import '../../models/project.dart';
import 'ric_registry.dart';
import 'ric_validation_result.dart';
import 'ric_validator.dart';

class RicValidationService {
  final RicRegistry registry;

  RicValidationService({
    RicRegistry? registry,
  }) : registry = registry ?? RicRegistry();

  Future<RicValidationReport> validateProject({
    required Project project,
    required List<Circuit> circuits,
  }) async {
    final context = RicValidationContext(
      project: project,
      circuits: circuits,
    );

    final results = <RicValidationResult>[];

    int validatorsExecuted = 0;
    int validatorsFailed = 0;

    for (final validator in registry.validators) {
      if (!validator.supports(context)) {
        continue;
      }

      validatorsExecuted++;

      try {
        final validatorResults =
        await validator.validate(context);

        results.addAll(validatorResults);
      } catch (_) {
        validatorsFailed++;
      }
    }

    return RicValidationReport(
      generatedAt: DateTime.now(),
      results: results,
      validatorsExecuted: validatorsExecuted,
      validatorsFailed: validatorsFailed,
    );
  }
}