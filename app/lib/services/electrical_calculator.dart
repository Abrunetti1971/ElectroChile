class ElectricalCalculator {
  ElectricalCalculator._();

  /// ==============================
  /// LEY DE OHM
  /// ==============================

  /// Corriente (A)
  static double current({
    required double voltage,
    required double power,
  }) {
    return power / voltage;
  }

  /// Potencia (W)
  static double power({
    required double voltage,
    required double current,
  }) {
    return voltage * current;
  }

  /// Resistencia (Ω)
  static double resistance({
    required double voltage,
    required double current,
  }) {
    return voltage / current;
  }

  /// Voltaje (V)
  static double voltage({
    required double current,
    required double resistance,
  }) {
    return current * resistance;
  }

  /// ==============================
  /// MONOFÁSICO
  /// ==============================

  static double monoCurrent({
    required double watts,
    required double voltage,
  }) {
    return watts / voltage;
  }

  /// ==============================
  /// TRIFÁSICO
  /// ==============================

  static double threePhaseCurrent({
    required double watts,
    required double voltage,
    double fp = 1.0,
  }) {
    return watts / (1.732 * voltage * fp);
  }
}