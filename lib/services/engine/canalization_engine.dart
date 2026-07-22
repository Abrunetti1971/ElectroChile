class CanalizationResult {
  final String conduit;
  final int diameter;
  final bool complies;
  final String message;

  const CanalizationResult({
    required this.conduit,
    required this.diameter,
    required this.complies,
    required this.message,
  });
}

class CanalizationEngine {
  CanalizationEngine._();

  static CanalizationResult calculate({
    required double section,
    required int conductors,
  }) {
    if (section <= 2.5) {
      if (conductors <= 3) {
        return const CanalizationResult(
          conduit: 'PVC',
          diameter: 20,
          complies: true,
          message: 'Cumple ocupación RIC.',
        );
      }

      return const CanalizationResult(
        conduit: 'PVC',
        diameter: 25,
        complies: true,
        message: 'Aumenta diámetro por cantidad de conductores.',
      );
    }

    if (section <= 6) {
      return const CanalizationResult(
        conduit: 'PVC',
        diameter: 25,
        complies: true,
        message: 'Cumple ocupación RIC.',
      );
    }

    if (section <= 16) {
      return const CanalizationResult(
        conduit: 'PVC',
        diameter: 32,
        complies: true,
        message: 'Cumple ocupación RIC.',
      );
    }

    if (section <= 35) {
      return const CanalizationResult(
        conduit: 'PVC',
        diameter: 40,
        complies: true,
        message: 'Cumple ocupación RIC.',
      );
    }

    return const CanalizationResult(
      conduit: 'PVC',
      diameter: 50,
      complies: true,
      message: 'Revisar cálculo definitivo.',
    );
  }
}