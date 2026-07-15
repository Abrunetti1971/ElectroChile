class VoltageDropResult {
  final double current;
  final double voltageDrop;
  final double voltageDropPercent;
  final bool complies;

  const VoltageDropResult({
    required this.current,
    required this.voltageDrop,
    required this.voltageDropPercent,
    required this.complies,
  });
}

class VoltageDropCalculator {
  VoltageDropCalculator._();

  /// Resistividad (Ω·mm²/m)
  static const double _rhoCopper = 0.0175;
  static const double _rhoAluminum = 0.0282;

  /// Calcula caída de tensión.
  ///
  /// voltage: 220 o 380 V
  /// power: W
  /// length: metros (un solo sentido)
  /// section: mm²
  /// copper: true = cobre, false = aluminio
  /// threePhase: true = trifásico
  static VoltageDropResult calculate({
    required double voltage,
    required double power,
    required double length,
    required double section,
    required bool copper,
    required bool threePhase,
  }) {
    if (voltage <= 0 ||
        power <= 0 ||
        length <= 0 ||
        section <= 0) {
      return const VoltageDropResult(
        current: 0,
        voltageDrop: 0,
        voltageDropPercent: 0,
        complies: false,
      );
    }

    final rho = copper ? _rhoCopper : _rhoAluminum;

    final current = threePhase
        ? power / (1.732 * voltage)
        : power / voltage;

    final drop = threePhase
        ? (1.732 * current * rho * length) / section
        : (2 * current * rho * length) / section;

    final percent = (drop / voltage) * 100;

    return VoltageDropResult(
      current: current,
      voltageDrop: drop,
      voltageDropPercent: percent,
      complies: percent <= 3.0,
    );
  }
}