class PowerService {
  static double calcularPotencia({
    required double voltaje,
    required double corriente,
  }) {
    return voltaje * corriente;
  }

  static double calcularVoltaje({
    required double potencia,
    required double corriente,
  }) {
    return potencia / corriente;
  }

  static double calcularCorriente({
    required double potencia,
    required double voltaje,
  }) {
    return potencia / voltaje;
  }
}