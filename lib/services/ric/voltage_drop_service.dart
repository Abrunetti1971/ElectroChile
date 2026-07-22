class VoltageDropResult {
  final double voltageDrop;

  final double voltageDropPercent;

  final double finalVoltage;

  final bool complies;

  final double recommendedSection;

  final String message;

  const VoltageDropResult({
    required this.voltageDrop,
    required this.voltageDropPercent,
    required this.finalVoltage,
    required this.complies,
    required this.recommendedSection,
    required this.message,
  });
}

class VoltageDropService {
  const VoltageDropService();

  static const double _rhoCopper = 0.0175;

  static const double _rhoAluminum = 0.0282;

  static const double _maximumDropPercent = 3.0;

  double _rho(String material) {
    switch (material.toLowerCase()) {
      case 'aluminio':
        return _rhoAluminum;

      default:
        return _rhoCopper;
    }
  }

  double calculateVoltageDrop({
    required double current,
    required double length,
    required double section,
    required String material,
    required int phases,
  }) {
    final rho = _rho(material);

    if (section <= 0) {
      return 0;
    }

    if (phases == 3) {
      return (1.732 * rho * length * current) / section;
    }

    return (2 * rho * length * current) / section;
  }

  VoltageDropResult validate({
    required double voltage,
    required double current,
    required double length,
    required double section,
    required String material,
    required int phases,
  }) {
    final drop = calculateVoltageDrop(
      current: current,
      length: length,
      section: section,
      material: material,
      phases: phases,
    );

    final percent = (drop / voltage) * 100;

    final finalVoltage = voltage - drop;

    final complies = percent <= _maximumDropPercent;

    return VoltageDropResult(
      voltageDrop: drop,
      voltageDropPercent: percent,
      finalVoltage: finalVoltage,
      complies: complies,
      recommendedSection: complies ? section : section * 1.5,
      message: complies
          ? 'Cumple con el límite de caída de tensión.'
          : 'La caída de tensión supera el límite permitido.',
    );
  }
}