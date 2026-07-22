class AmpacityResult {
  final double minimumSection;
  final double ampacity;
  final bool complies;
  final String message;

  const AmpacityResult({
    required this.minimumSection,
    required this.ampacity,
    required this.complies,
    required this.message,
  });
}

class AmpacityService {
  const AmpacityService();

  static final Map<double, double> _copperPVC = <double, double>{
    1.5: 18,
    2.5: 24,
    4.0: 32,
    6.0: 41,
    10.0: 57,
    16.0: 76,
    25.0: 101,
    35.0: 125,
    50.0: 150,
    70.0: 192,
    95.0: 232,
    120.0: 269,
    150.0: 309,
    185.0: 353,
    240.0: 415,
  };

  double currentCapacity(double section) {
    return _copperPVC[section] ?? 0;
  }

  double minimumSection(double current) {
    for (final entry in _copperPVC.entries) {
      if (current <= entry.value) {
        return entry.key;
      }
    }

    return _copperPVC.keys.last;
  }

  AmpacityResult validate({
    required double current,
    required double section,
  }) {
    final capacity = currentCapacity(section);

    if (capacity <= 0) {
      return const AmpacityResult(
        minimumSection: 0,
        ampacity: 0,
        complies: false,
        message: 'Sección de conductor no soportada.',
      );
    }

    final requiredSection = minimumSection(current);
    final complies = current <= capacity;

    return AmpacityResult(
      minimumSection: requiredSection,
      ampacity: capacity,
      complies: complies,
      message: complies
          ? 'Cumple con la ampacidad.'
          : 'La sección del conductor es insuficiente para la corriente del circuito.',
    );
  }

  List<double> availableSections() {
    return List<double>.from(_copperPVC.keys);
  }

  bool isStandardSection(double section) {
    return _copperPVC.containsKey(section);
  }
}