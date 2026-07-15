import 'electrical_analysis.dart';

class EngineeringEngine {
  static ElectricalAnalysis analyzeOhm({
    double? voltage,
    double? current,
    double? resistance,
  }) {
    if (voltage != null && current != null) {
      final power = voltage * current;
      final resistance = voltage / current;

      return ElectricalAnalysis(
        voltage: voltage,
        current: current,
        resistance: resistance,
        power: power,
        title: 'Análisis eléctrico',
        formula: 'P = V × I / R = V ÷ I',
        explanation:
        'Con $voltage V y $current A, la potencia aproximada es ${power.toStringAsFixed(2)} W.',
        technicalNote:
        'Este valor sirve como base para seleccionar conductor, protección y verificar condiciones del circuito.',
      );
    }

    if (voltage != null && resistance != null) {
      final current = voltage / resistance;
      final power = voltage * current;

      return ElectricalAnalysis(
        voltage: voltage,
        current: current,
        resistance: resistance,
        power: power,
        title: 'Análisis eléctrico',
        formula: 'I = V ÷ R / P = V × I',
        explanation:
        'Con $voltage V y $resistance Ω, la corriente estimada es ${current.toStringAsFixed(2)} A.',
        technicalNote:
        'La corriente calculada permite evaluar conductor, protección y carga conectada.',
      );
    }

    if (current != null && resistance != null) {
      final voltage = current * resistance;
      final power = voltage * current;

      return ElectricalAnalysis(
        voltage: voltage,
        current: current,
        resistance: resistance,
        power: power,
        title: 'Análisis eléctrico',
        formula: 'V = I × R / P = V × I',
        explanation:
        'Con $current A y $resistance Ω, el voltaje requerido es ${voltage.toStringAsFixed(2)} V.',
        technicalNote:
        'Este cálculo permite estimar la tensión necesaria para una carga determinada.',
      );
    }

    throw Exception('Debe ingresar al menos dos valores eléctricos válidos.');
  }
}