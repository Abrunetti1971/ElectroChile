class ConductorsResult {
  //--------------------------------------
  // Datos de entrada
  //--------------------------------------

  final double voltaje;

  final double corriente;

  final double longitud;

  final String material;

  final String sistema;

  final String metodoInstalacion;

  final String aislacion;

  final double temperatura;

  final int circuitosAgrupados;

  //--------------------------------------
  // Factores de corrección
  //--------------------------------------

  final double factorTemperatura;

  final double factorAgrupamiento;

  //--------------------------------------
  // Resultados
  //--------------------------------------

  final double conductorAmpacidad;

  final double conductorCaida;

  final double conductorFinal;

  final int proteccion;

  final String diferencial;

  //--------------------------------------
  // Estado
  //--------------------------------------

  final bool cumple;

  final String observacion;

  const ConductorsResult({

    required this.voltaje,

    required this.corriente,

    required this.longitud,

    required this.material,

    required this.sistema,

    required this.metodoInstalacion,

    required this.aislacion,

    required this.temperatura,

    required this.circuitosAgrupados,

    required this.factorTemperatura,

    required this.factorAgrupamiento,

    required this.conductorAmpacidad,

    required this.conductorCaida,

    required this.conductorFinal,

    required this.proteccion,

    required this.diferencial,

    required this.cumple,

    required this.observacion,

  });

  //--------------------------------------
  // Getters
  //--------------------------------------

  String get voltajeTexto =>
      "${voltaje.toStringAsFixed(0)} V";

  String get corrienteTexto =>
      "${corriente.toStringAsFixed(1)} A";

  String get longitudTexto =>
      "${longitud.toStringAsFixed(1)} m";

  String get conductorAmpacidadTexto =>
      "${conductorAmpacidad.toStringAsFixed(1)} mm²";

  String get conductorCaidaTexto =>
      "${conductorCaida.toStringAsFixed(1)} mm²";

  String get conductorFinalTexto =>
      "${conductorFinal.toStringAsFixed(1)} mm²";

  String get proteccionTexto =>
      "$proteccion A";

  String get temperaturaTexto =>
      "${temperatura.toStringAsFixed(0)} °C";

  String get factorTemperaturaTexto =>
      factorTemperatura.toStringAsFixed(2);

  String get factorAgrupamientoTexto =>
      factorAgrupamiento.toStringAsFixed(2);

  String get estadoTexto =>
      cumple
          ? "Cumple SEC"
          : "No cumple SEC";
}