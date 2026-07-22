import '../calculators/conductor_calculator.dart';
import '../protections/protection_calculator.dart';

class CircuitEngineResult {
  final ConductorSelectionResult conductor;
  final ProtectionResult protection;

  const CircuitEngineResult({
    required this.conductor,
    required this.protection,
  });
}

class CircuitEngine {
  CircuitEngine._();

  static CircuitEngineResult calculate({
    required String circuitType,
    required double voltage,
    required double power,
    required double length,
    required bool copper,
    required bool threePhase,
  }) {
    final conductor = ConductorCalculator.calculate(
      circuitType: circuitType,
      voltage: voltage,
      power: power,
      length: length,
      copper: copper,
      threePhase: threePhase,
    );

    final protection = ProtectionCalculator.calculate(
      circuitType: circuitType,
      current: conductor.current,
      conductorSection: conductor.section,
      copper: copper,
    );

    return CircuitEngineResult(
      conductor: conductor,
      protection: protection,
    );
  }
}