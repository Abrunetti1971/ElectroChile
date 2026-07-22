class RicRules {
  RicRules._();

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

  static const int differentialSensitivity = 30;

  static const double maximumVoltageDrop = 3.0;

  static double minimumSection(String type) {
    switch (type.trim().toLowerCase()) {
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

  static int minimumProtection(String type) {
    switch (type.trim().toLowerCase()) {
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