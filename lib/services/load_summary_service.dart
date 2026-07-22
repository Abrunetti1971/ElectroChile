import '../models/circuit.dart';

class CircuitSummary {
  final int number;
  final String name;
  final String type;
  final double power;
  final double current;
  final String conductor;
  final String protection;
  final double voltageDrop;
  final bool ok;

  const CircuitSummary({
    required this.number,
    required this.name,
    required this.type,
    required this.power,
    required this.current,
    required this.conductor,
    required this.protection,
    required this.voltageDrop,
    required this.ok,
  });
}

class LoadSummary {
  final List<CircuitSummary> circuits;
  final double installedPower;
  final double installedCurrent;
  final double demandPower;
  final double demandCurrent;
  final String mainBreaker;
  final String mainDifferential;
  final bool ricCompliant;
  final List<String> warnings;

  const LoadSummary({
    required this.circuits,
    required this.installedPower,
    required this.installedCurrent,
    required this.demandPower,
    required this.demandCurrent,
    required this.mainBreaker,
    required this.mainDifferential,
    required this.ricCompliant,
    required this.warnings,
  });
}

class LoadSummaryService {
  const LoadSummaryService();

  LoadSummary build(List<Circuit> circuits) {
    final List<CircuitSummary> rows = [];
    double p = 0.0;
    double i = 0.0;
    double dp = 0.0;
    final List<String> warnings = [];

    for (final c in circuits) {
      p += c.power;
      i += c.current;
      dp += c.power * c.demandFactor;

      rows.add(
        CircuitSummary(
          number: c.number,
          name: c.name,
          type: c.type,
          power: c.power,
          current: c.current,
          conductor: '${c.conductorSection} mm² ${c.conductorMaterial}',
          protection: c.protection,
          voltageDrop: 0.0,
          ok: c.status.toLowerCase() != 'error',
        ),
      );

      if (c.status.toLowerCase() == 'warning') {
        warnings.add('Circuito ${c.number}: ${c.name} requiere revisión.');
      }
    }

    final double dc = circuits.isEmpty
        ? 0.0
        : (dp / circuits.first.voltage).toDouble();

    return LoadSummary(
      circuits: rows,
      installedPower: p,
      installedCurrent: i,
      demandPower: dp,
      demandCurrent: dc,
      mainBreaker: _breaker(dc),
      mainDifferential: _diff(dc),
      ricCompliant: warnings.isEmpty,
      warnings: warnings,
    );
  }

  String _breaker(double a) {
    for (final s in const [10, 16, 20, 25, 32, 40, 50, 63]) {
      if (a <= s) return '$s A';
    }
    return '80 A';
  }

  String _diff(double a) {
    if (a <= 25) return '25 A / 30 mA';
    if (a <= 40) return '40 A / 30 mA';
    if (a <= 63) return '63 A / 30 mA';
    return '80 A / 30 mA';
  }
}
