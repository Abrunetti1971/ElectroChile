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

  static const List<double> standardSections = [
    1.5, 2.5, 4, 6, 10, 16, 25, 35, 50, 70, 95, 120, 150, 185, 240,
  ];

  static ConductorSelectionResult calculate({
    required double voltage,
    required double power,
    required double length,
    required bool copper,
    required bool threePhase,
    double maxVoltageDropPercent = 3.0,
  }) {
    for (final section in standardSections) {
      final result = VoltageDropCalculator.calculate(
        voltage: voltage,
        power: power,
        length: length,
        section: section,
        copper: copper,
        threePhase: threePhase,
      );

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

    final result = VoltageDropCalculator.calculate(
      voltage: voltage,
      power: power,
      length: length,
      section: standardSections.last,
      copper: copper,
      threePhase: threePhase,
    );

    return ConductorSelectionResult(
      current: result.current,
      section: standardSections.last,
      voltageDrop: result.voltageDrop,
      voltageDropPercent: result.voltageDropPercent,
      complies: false,
    );
  }
}
