import '../rules/ampacity_tables.dart';
import '../rules/ric_rules.dart';
import 'voltage_drop_calculator.dart';

class ConductorSelectionResult {
  final double current;
  final double section;
  final double voltageDrop;
  final double voltageDropPercent;
  final bool complies;

  const ConductorSelectionResult({
    required this.current,
    required this.section,
    required this.voltageDrop,
    required this.voltageDropPercent,
    required this.complies,
  });
}

class ConductorCalculator {
  ConductorCalculator._();

  static ConductorSelectionResult calculate({
    required String circuitType,
    required double voltage,
    required double power,
    required double length,
    required bool copper,
    required bool threePhase,
    double maxVoltageDropPercent = RicRules.maximumVoltageDrop,
  }) {
    final minimumSection = RicRules.minimumSection(circuitType);

    final availableSections = RicRules.standardSections
        .where((section) => section >= minimumSection)
        .toList();

    for (final section in availableSections) {
      final result = VoltageDropCalculator.calculate(
        voltage: voltage,
        power: power,
        length: length,
        section: section,
        copper: copper,
        threePhase: threePhase,
      );

      if (!AmpacityTables.complies(
        current: result.current,
        section: section,
        copperConductor: copper,
      )) {
        continue;
      }

      if (result.voltageDropPercent <= maxVoltageDropPercent) {
        return ConductorSelectionResult(
          current: result.current,
          section: section,
          voltageDrop: result.voltageDrop,
          voltageDropPercent: result.voltageDropPercent,
          complies: true,
        );
      }
    }

    final fallbackSection = availableSections.last;

    final result = VoltageDropCalculator.calculate(
      voltage: voltage,
      power: power,
      length: length,
      section: fallbackSection,
      copper: copper,
      threePhase: threePhase,
    );

    return ConductorSelectionResult(
      current: result.current,
      section: fallbackSection,
      voltageDrop: result.voltageDrop,
      voltageDropPercent: result.voltageDropPercent,
      complies: false,
    );
  }
}
