import 'ric_database.dart';

class RicRepository {
  RicRepository._();

  /// Obtiene la ampacidad para una sección de conductor.
  static double copperAmpacity(double section) {
    return RicDatabase.getAmpacity(section) ?? 0;
  }

  /// Devuelve el disyuntor normalizado inmediatamente superior.
  static int nearestBreaker({
    required double current,
    required int minimum,
  }) {
    for (final breaker in RicDatabase.breakers) {
      if (breaker >= current && breaker >= minimum) {
        return breaker;
      }
    }

    return RicDatabase.breakers.last;
  }

  /// Factor de agrupamiento.
  static double groupingFactor(int circuits) {
    return RicDatabase.groupingFactors[circuits] ??
        RicDatabase.groupingFactors.values.last;
  }

  /// Factor de corrección por temperatura.
  static double temperatureFactor(int temperature) {
    return RicDatabase.temperatureFactors[temperature] ??
        1.0;
  }
}