class ProtectionResult {
  final int recommendedBreaker;

  final bool complies;

  final String message;

  const ProtectionResult({
    required this.recommendedBreaker,
    required this.complies,
    required this.message,
  });
}

class ProtectionService {
  const ProtectionService();

  static final List<int> _standardBreakers = <int>[
    2,
    4,
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

  int recommendedBreaker(double current) {
    for (final breaker in _standardBreakers) {
      if (current <= breaker) {
        return breaker;
      }
    }

    return _standardBreakers.last;
  }

  ProtectionResult validate({
    required double current,
    required String installedProtection,
  }) {
    final recommended = recommendedBreaker(current);

    final installed = int.tryParse(
      installedProtection.replaceAll(RegExp(r'[^0-9]'), ''),
    ) ??
        0;

    if (installed == 0) {
      return ProtectionResult(
        recommendedBreaker: recommended,
        complies: false,
        message: 'Protección no definida.',
      );
    }

    if (installed == recommended) {
      return ProtectionResult(
        recommendedBreaker: recommended,
        complies: true,
        message: 'La protección es adecuada.',
      );
    }

    if (installed < recommended) {
      return ProtectionResult(
        recommendedBreaker: recommended,
        complies: false,
        message:
        'La protección instalada es inferior a la recomendada.',
      );
    }

    return ProtectionResult(
      recommendedBreaker: recommended,
      complies: false,
      message:
      'La protección instalada es superior a la recomendada.',
    );
  }

  List<int> availableBreakers() {
    return List<int>.from(_standardBreakers);
  }

  bool isStandardBreaker(int breaker) {
    return _standardBreakers.contains(breaker);
  }
}