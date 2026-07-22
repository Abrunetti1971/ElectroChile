import 'ric_validation_result.dart';
import 'ric_validator.dart';

class RicProjectValidator extends RicValidator {
  const RicProjectValidator();

  @override
  String get id => 'project';

  @override
  String get name => 'Proyecto';

  @override
  Future<List<RicValidationResult>> validate(
      RicValidationContext context,
      ) async {
    final project = context.project;
    final results = <RicValidationResult>[];

    if (project.name.trim().isEmpty) {
      results.add(
        const RicValidationResult(
          validatorId: 'project',
          code: 'PRJ-001',
          title: 'Nombre del proyecto',
          message: 'El proyecto no tiene nombre.',
          recommendation: 'Ingrese un nombre para el proyecto.',
          severity: RicSeverity.error,
        ),
      );
    }

    if (project.client.trim().isEmpty) {
      results.add(
        const RicValidationResult(
          validatorId: 'project',
          code: 'PRJ-002',
          title: 'Cliente',
          message: 'No existe cliente asociado.',
          recommendation: 'Ingrese el nombre del cliente.',
          severity: RicSeverity.warning,
        ),
      );
    }

    if (project.address.trim().isEmpty) {
      results.add(
        const RicValidationResult(
          validatorId: 'project',
          code: 'PRJ-003',
          title: 'Dirección',
          message: 'No existe dirección del proyecto.',
          recommendation: 'Ingrese la dirección del proyecto.',
          severity: RicSeverity.warning,
        ),
      );
    }

    if (project.city.trim().isEmpty) {
      results.add(
        const RicValidationResult(
          validatorId: 'project',
          code: 'PRJ-004',
          title: 'Comuna',
          message: 'No existe comuna del proyecto.',
          recommendation: 'Ingrese la comuna.',
          severity: RicSeverity.warning,
        ),
      );
    }

    if (project.region.trim().isEmpty) {
      results.add(
        const RicValidationResult(
          validatorId: 'project',
          code: 'PRJ-005',
          title: 'Región',
          message: 'No existe región del proyecto.',
          recommendation: 'Ingrese la región.',
          severity: RicSeverity.warning,
        ),
      );
    }

    if (project.distributor.trim().isEmpty) {
      results.add(
        const RicValidationResult(
          validatorId: 'project',
          code: 'PRJ-006',
          title: 'Distribuidora',
          message: 'No existe empresa distribuidora.',
          recommendation: 'Seleccione la empresa distribuidora.',
          severity: RicSeverity.warning,
        ),
      );
    }

    if (!context.hasCircuits) {
      results.add(
        const RicValidationResult(
          validatorId: 'project',
          code: 'PRJ-007',
          title: 'Proyecto sin circuitos',
          message: 'El proyecto aún no contiene circuitos.',
          recommendation: 'Agregue al menos un circuito antes de validar.',
          severity: RicSeverity.error,
        ),
      );
    }

    return results;
  }
}