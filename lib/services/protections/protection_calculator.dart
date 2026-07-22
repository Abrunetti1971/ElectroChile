import '../rules/ampacity_tables.dart';
import '../rules/ric_rules.dart';

class ProtectionResult {
  final double ib;
  final double iz;
  final int inBreaker;
  final bool complies;
  final String message;

  const ProtectionResult({
    required this.ib,
    required this.iz,
    required this.inBreaker,
    required this.complies,
    required this.message,
  });
}

class ProtectionCalculator {
  ProtectionCalculator._();

  static const List<int> _standardBreakers = [
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
    160,
    200,
    250,
  ];

  static ProtectionResult calculate({
    required String circuitType,
    required double current,
    required double conductorSection,
    required bool copper,
  }) {
    final ib = current;

    final iz = AmpacityTables.ampacity(
      section: conductorSection,
      copperConductor: copper,
    );

    final minimumBreaker =
    RicRules.minimumProtection(circuitType);

    int breaker = minimumBreaker;

    for (final value in _standardBreakers) {
      if (value >= ib && value >= minimumBreaker) {
        breaker = value;
        break;
      }
    }

    final complies =
        ib <= breaker &&
            breaker <= iz;

    return ProtectionResult(
      ib: ib,
      iz: iz,
      inBreaker: breaker,
      complies: complies,
      message: complies
          ? 'Cumple RIC'
          : 'La protección o el conductor deben redimensionarse.',
    );
  }
}