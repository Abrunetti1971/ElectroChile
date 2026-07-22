import '../models/project.dart';
import '../models/circuit.dart';
import '../models/load_summary.dart';
import '../models/sec/sec_validation.dart';

import 'load_calculator_service.dart';
import 'sec/ric_validation_service.dart';

class ProjectEngine {
  final Project project;
  final List<Circuit> circuits;

  final LoadCalculatorService _loadCalculator =
  const LoadCalculatorService();

  final RicValidationService _validator =
  const RicValidationService();

  ProjectEngine({
    required this.project,
    required this.circuits,
  });

  /// Resumen completo de cargas
  LoadSummary get loadSummary =>
      _loadCalculator.calculate(circuits);

  /// Potencia instalada
  double get installedPower =>
      loadSummary.installedPower;

  /// Potencia demandada
  double get demandPower =>
      loadSummary.demandPower;

  /// Corriente total
  double get installedCurrent =>
      loadSummary.totalCurrent;

  /// Cantidad de circuitos
  int get circuitCount =>
      circuits.length;

  /// Validaciones
  List<SecValidation> get validations =>
      _validator.validate(circuits);

  bool get hasErrors =>
      validations.any((v) => v.isFailed);

  bool get hasWarnings =>
      validations.any((v) => v.isWarning);

  bool get isValid =>
      !hasErrors;

  double get compliance {
    if (validations.isEmpty) {
      return 100;
    }

    final passed =
        validations.where((v) => v.isPassed).length;

    return (passed / validations.length) * 100;
  }
}