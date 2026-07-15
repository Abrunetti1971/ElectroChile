import '../data/conductors_catalog.dart';

class ElectricalCalculatorService {
  const ElectricalCalculatorService();

  double calculateCurrent({
    required double power,
    required double voltage,
    double powerFactor = 1,
  }) {
    if (voltage <= 0) return 0;

    return power / (voltage * powerFactor);
  }

  double recommendedSectionForCircuit({
    required String circuitType,
    required double current,
    required double length,
    double voltage = 220,
  }) {
    final minimumSection =
    _minimumSectionByCircuit(circuitType);

    for (final conductor
    in ConductorsCatalog.copperPVC) {
      if (conductor.section < minimumSection) {
        continue;
      }

      if (conductor.maxCurrent < current) {
        continue;
      }

      final drop = voltageDrop(
        current: current,
        length: length,
        section: conductor.section,
        voltage: voltage,
      );

      if (drop <= 3) {
        return conductor.section;
      }
    }

    return ConductorsCatalog
        .copperPVC
        .last
        .section;
  }

  int recommendedBreaker(
      double current, {
        String circuitType = '',
      }) {
    const breakers = [
      6,
      10,
      16,
      20,
      25,
      32,
      40,
      50,
      63,
      80,
      100,
      125,
    ];

    for (final breaker in breakers) {
      if (current <= breaker) {
        return breaker;
      }
    }

    return breakers.last;
  }

  String recommendedDifferential(
      double breaker,
      ) {
    if (breaker <= 25) {
      return "25 A - 30 mA";
    }

    if (breaker <= 40) {
      return "40 A - 30 mA";
    }

    if (breaker <= 63) {
      return "63 A - 30 mA";
    }

    return "80 A - 30 mA";
  }

  double voltageDrop({
    required double current,
    required double length,
    required double section,
    double voltage = 220,
    double resistivity = 0.0175,
  }) {
    final drop =
        (2 *
            resistivity *
            length *
            current) /
            section;

    return (drop / voltage) * 100;
  }

  bool compliesVoltageDrop(
      double percent,
      ) {
    return percent <= 3;
  }

  double _minimumSectionByCircuit(
      String type,
      ) {
    switch (type.toLowerCase()) {
      case 'alumbrado':
        return 1.5;

      case 'enchufes':
        return 2.5;

      case 'fuerza':
        return 2.5;

      case 'motor':
        return 2.5;

      default:
        return 1.5;
    }
  }
}