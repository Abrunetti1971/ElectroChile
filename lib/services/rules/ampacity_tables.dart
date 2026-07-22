class AmpacityTables {
  AmpacityTables._();

  static const List<(double, double)> _copper = [
    (1.5,18),(2.5,24),(4,32),(6,41),(10,57),(16,76),
    (25,101),(35,125),(50,151),(70,192),(95,232),
    (120,269),(150,309),(185,353),(240,415),
  ];

  static const List<(double, double)> _aluminum = [
    (2.5,19),(4,25),(6,32),(10,44),(16,59),
    (25,77),(35,96),(50,116),(70,148),(95,179),
    (120,207),(150,238),(185,271),(240,318),
  ];

  static double ampacity({
    required double section,
    required bool copperConductor,
  }) {
    final table = copperConductor ? _copper : _aluminum;
    for (final row in table) {
      if (row.$1 == section) return row.$2;
    }
    return 0;
  }

  static bool complies({
    required double current,
    required double section,
    required bool copperConductor,
  }) {
    return current <= ampacity(
      section: section,
      copperConductor: copperConductor,
    );
  }
}
