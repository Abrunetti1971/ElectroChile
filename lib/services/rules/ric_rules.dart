class RicRules {
  RicRules._();

  // Secciones normalizadas (mm²)
  static const List<double> standardSections = [
    1.5,
    2.5,
    4,
    6,
    10,
    16,
    25,
    35,
    50,
    70,
    95,
    120,
    150,
    185,
    240,
  ];

  // Sensibilidad diferencial (mA)
  static const int differentialSensitivity = 30;

  // Máxima caída de tensión (%)
  static const double maximumVoltageDrop = 3.0;

  // Sección mínima según RIC
  static double minimumSection(String type) {
    final key = type.trim().toLowerCase();

    switch (key) {
      case 'alumbrado':
        return 1.5;

      case 'enchufes':
      case 'fuerza':
      case 'motor':
      case 'aire acondicionado':
      case 'porton':
      case 'portón':
      case 'bomba':
      default:
        return 2.5;
    }
  }

  // Protección mínima según tipo de circuito
  static int minimumProtection(String type) {
    final key = type.trim().toLowerCase();

    switch (key) {
      case 'alumbrado':
        return 10;

      case 'enchufes':
      case 'fuerza':
      case 'motor':
      case 'aire acondicionado':
      case 'porton':
      case 'portón':
      case 'bomba':
      default:
        return 16;
    }
  }
}