class ConductorSizingResult {
  final double conductorSection;
  final String protection;
  final String differential;
  final String conduit;
  final double current;
  final double voltageDrop;
  final List<String> warnings;

  const ConductorSizingResult({
    required this.conductorSection,
    required this.protection,
    required this.differential,
    required this.conduit,
    required this.current,
    required this.voltageDrop,
    required this.warnings,
  });
}

class ConductorSizingService {
  const ConductorSizingService();

  ConductorSizingResult calculate({
    required double power,
    required double voltage,
    required double length,
    String conductorMaterial = 'Cobre',
    double demandFactor = 1.0,
  }) {
    final current = (power * demandFactor) / voltage;

    double section;
    if (current <= 10) {
      section = 1.5;
    } else if (current <= 16) {
      section = 2.5;
    } else if (current <= 20) {
      section = 4.0;
    } else if (current <= 25) {
      section = 6.0;
    } else if (current <= 32) {
      section = 10.0;
    } else if (current <= 40) {
      section = 16.0;
    } else {
      section = 25.0;
    }

    final resistance = conductorMaterial == 'Aluminio' ? 0.0282 : 0.0175;
    final voltageDrop = (2 * length * current * resistance) / section;

    final breaker = _breaker(current);
    final differential = _differential(current);

    final warnings = <String>[];
    if ((voltageDrop / voltage) * 100 > 3) {
      warnings.add('La caída de tensión supera el 3%.');
    }

    return ConductorSizingResult(
      conductorSection: section,
      protection: breaker,
      differential: differential,
      conduit: 'PVC Conduit',
      current: current,
      voltageDrop: voltageDrop,
      warnings: warnings,
    );
  }

  String _breaker(double current) {
    const sizes = [10, 16, 20, 25, 32, 40, 50, 63];
    for (final s in sizes) {
      if (current <= s) return '$s A';
    }
    return '80 A';
  }

  String _differential(double current) {
    if (current <= 25) return '25 A / 30 mA';
    if (current <= 40) return '40 A / 30 mA';
    if (current <= 63) return '63 A / 30 mA';
    return '80 A / 30 mA';
  }
}
