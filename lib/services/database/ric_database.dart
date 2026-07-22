class RicDatabase {
  RicDatabase._();

  /// Secciones normalizadas

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

  /// Disyuntores normalizados

  static const List<int> breakers = [
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

  /// Tabla de ampacidad
  ///
  /// (Sección, Ampacidad)

  static const List<(double, double)> copperAmpacity = [
    (1.5, 18),
    (2.5, 24),
    (4, 32),
    (6, 41),
    (10, 57),
    (16, 76),
    (25, 101),
    (35, 125),
    (50, 151),
    (70, 192),
    (95, 232),
    (120, 269),
    (150, 309),
    (185, 353),
    (240, 415),
  ];

  static double? getAmpacity(double section) {
    for (final row in copperAmpacity) {
      if (row.$1 == section) {
        return row.$2;
      }
    }
    return null;
  }

  /// Temperatura

  static const Map<int, double> temperatureFactors = {
    25: 1.03,
    30: 1.00,
    35: 0.94,
    40: 0.87,
    45: 0.79,
    50: 0.71,
  };

  /// Agrupamiento

  static const Map<int, double> groupingFactors = {
    1: 1.00,
    2: 0.80,
    3: 0.70,
    4: 0.65,
    5: 0.60,
    6: 0.57,
    7: 0.54,
    8: 0.52,
    9: 0.50,
  };
}