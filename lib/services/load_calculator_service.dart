import '../models/circuit.dart';
import '../models/load_summary.dart';
import 'electrical_calculator_service.dart';

class LoadCalculatorService {
  const LoadCalculatorService();

  static const ElectricalCalculatorService _calculator =
  ElectricalCalculatorService();

  static const double _systemVoltage = 220.0;
  static const double _feederLength = 15.0;
  static const double _minimumFeederSection = 4.0;

  LoadSummary calculate(
      List<Circuit> circuits,
      ) {
    final List<LoadCircuit> loadCircuits = [];

    double installedPower = 0.0;
    double lightingPower = 0.0;
    double otherPower = 0.0;

    for (final circuit in circuits) {
      final section =
      _calculator.recommendedSectionForCircuit(
        circuitType: circuit.type,
        current: circuit.current,
        length: circuit.length,
        voltage: circuit.voltage,
      );

      final breaker =
      _calculator.recommendedBreaker(
        circuit.current,
        circuitType: circuit.type,
      );

      installedPower += circuit.power;

      if (_isLightingCircuit(circuit.type)) {
        lightingPower += circuit.power;
      } else {
        otherPower += circuit.power;
      }

      loadCircuits.add(
        LoadCircuit(
          name: circuit.name,
          type: circuit.type,
          power: circuit.power,
          current: circuit.current,
          conductorSection: section,
          breaker: breaker,
        ),
      );
    }

    final double lightingDemand =
    _calculateResidentialLightingDemand(
      lightingPower,
    );

    final double demandPower =
        lightingDemand + otherPower;

    final double totalCurrent =
    demandPower <= 0
        ? 0.0
        : demandPower / _systemVoltage;

    final double calculatedFeederSection =
    _calculator.recommendedSectionForCircuit(
      circuitType: 'alimentador',
      current: totalCurrent,
      length: _feederLength,
      voltage: _systemVoltage,
    );

    final double feederSection =
    calculatedFeederSection <
        _minimumFeederSection
        ? _minimumFeederSection
        : calculatedFeederSection;

    final int mainBreaker =
    _calculator.recommendedBreaker(
      totalCurrent,
      circuitType: 'alimentador',
    );

    final String differential =
    _calculator.recommendedDifferential(
      mainBreaker.toDouble(),
    );

    return LoadSummary(
      circuits: loadCircuits,
      installedPower: installedPower,
      demandPower: demandPower,
      totalCurrent: totalCurrent,
      feederSection: feederSection,
      mainBreaker: mainBreaker,
      differential: differential,
      recommendedService:
      _recommendedService(
        demandPower,
      ),
    );
  }

  double _calculateResidentialLightingDemand(
      double lightingPower,
      ) {
    if (lightingPower <= 0) {
      return 0.0;
    }

    const double firstSectionLimit = 3000.0;
    const double secondSectionLimit = 120000.0;

    if (lightingPower <= firstSectionLimit) {
      return lightingPower;
    }

    if (lightingPower <= secondSectionLimit) {
      final double secondSection =
          lightingPower - firstSectionLimit;

      return firstSectionLimit +
          (secondSection * 0.35);
    }

    final double secondSection =
        secondSectionLimit -
            firstSectionLimit;

    final double thirdSection =
        lightingPower -
            secondSectionLimit;

    return firstSectionLimit +
        (secondSection * 0.35) +
        (thirdSection * 0.25);
  }

  bool _isLightingCircuit(
      String circuitType,
      ) {
    final normalized =
    _normalize(circuitType);

    return normalized.contains(
      'alumbrado',
    );
  }

  String _recommendedService(
      double demandPower,
      ) {
    if (demandPower <= 0) {
      return 'Sin carga calculada';
    }

    if (demandPower <= 6000) {
      return 'Empalme Monofásico 6 kW';
    }

    if (demandPower <= 8000) {
      return 'Empalme Monofásico 8 kW';
    }

    if (demandPower <= 10000) {
      return 'Empalme Monofásico 10 kW';
    }

    if (demandPower <= 15000) {
      return 'Empalme Monofásico 15 kW';
    }

    return 'Evaluar Empalme Trifásico';
  }

  String _normalize(
      String value,
      ) {
    return value
        .trim()
        .toLowerCase()
        .replaceAll('á', 'a')
        .replaceAll('é', 'e')
        .replaceAll('í', 'i')
        .replaceAll('ó', 'o')
        .replaceAll('ú', 'u');
  }
}