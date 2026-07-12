class OhmCalculator {
  /// Corriente (A) = Potencia (W) / Voltaje (V)
  static double calcularCorriente({
    required double voltaje,
    required double potencia,
  }) {
    if (voltaje <= 0) {
      throw Exception("El voltaje debe ser mayor que cero.");
    }

    return potencia / voltaje;
  }

  /// Voltaje (V) = Potencia (W) / Corriente (A)
  static double calcularVoltaje({
    required double corriente,
    required double potencia,
  }) {
    if (corriente <= 0) {
      throw Exception("La corriente debe ser mayor que cero.");
    }

    return potencia / corriente;
  }

  /// Potencia (W) = Voltaje (V) × Corriente (A)
  static double calcularPotencia({
    required double voltaje,
    required double corriente,
  }) {
    return voltaje * corriente;
  }

  /// Resistencia (Ω) = Voltaje (V) / Corriente (A)
  static double calcularResistencia({
    required double voltaje,
    required double corriente,
  }) {
    if (corriente <= 0) {
      throw Exception("La corriente debe ser mayor que cero.");
    }

    return voltaje / corriente;
  }
}