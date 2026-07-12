class VoltageDropResult {
  /// Datos de entrada
  final double voltaje;
  final double corriente;
  final double longitud;

  final bool cobre;
  final bool trifasico;

  /// Resultado del cálculo

  /// Sección mínima por ampacidad
  final double conductorAmpacidad;

  /// Sección final considerando caída de tensión
  final double conductor;

  final int proteccion;

  final String diferencial;

  final double caidaVolt;

  final double caidaPorcentaje;

  final bool cumple;

  final String observacion;

  const VoltageDropResult({
    required this.voltaje,
    required this.corriente,
    required this.longitud,
    required this.cobre,
    required this.trifasico,
    required this.conductorAmpacidad,
    required this.conductor,
    required this.proteccion,
    required this.diferencial,
    required this.caidaVolt,
    required this.caidaPorcentaje,
    required this.cumple,
    required this.observacion,
  });

  String get material =>
      cobre ? "Cobre" : "Aluminio";

  String get sistema =>
      trifasico ? "Trifásico" : "Monofásico";

  bool get aumentoPorCaida =>
      conductor > conductorAmpacidad;

  String get conductorTexto =>
      "${conductor.toStringAsFixed(1)} mm²";

  String get conductorAmpacidadTexto =>
      "${conductorAmpacidad.toStringAsFixed(1)} mm²";

  String get caidaTexto =>
      "${caidaVolt.toStringAsFixed(2)} V";

  String get porcentajeTexto =>
      "${caidaPorcentaje.toStringAsFixed(2)} %";

  String get proteccionTexto =>
      "$proteccion A";
}