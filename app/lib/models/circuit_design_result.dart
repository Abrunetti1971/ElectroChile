class CircuitDesignResult {
  final double current;

  final double recommendedSection;

  final double voltageDropPercent;

  final double voltageDropVolts;

  final int recommendedBreaker;

  final int recommendedRcd;

  final String conduit;

  final bool complies;

  final List<String> observations;

  const CircuitDesignResult({
    required this.current,
    required this.recommendedSection,
    required this.voltageDropPercent,
    required this.voltageDropVolts,
    required this.recommendedBreaker,
    required this.recommendedRcd,
    required this.conduit,
    required this.complies,
    required this.observations,
  });
}