class OhmService {
  static double calcularVoltaje({
    required double corriente,
    required double resistencia,
  }) {
    return corriente * resistencia;
  }

  static double calcularCorriente({
    required double voltaje,
    required double resistencia,
  }) {
    return voltaje / resistencia;
  }

  static double calcularResistencia({
    required double voltaje,
    required double corriente,
  }) {
    return voltaje / corriente;
  }
}