class ElectricalProject {

//--------------------------------------
// Información general
//--------------------------------------

final String id;
final String nombre;
final DateTime fecha;

//--------------------------------------
// Tipo de proyecto
//--------------------------------------

final String tipo;

//--------------------------------------
// Datos eléctricos
//--------------------------------------

final double voltaje;
final double corriente;
final double longitud;

final String material;
final String sistema;

//--------------------------------------
// Conductores
//--------------------------------------

final double conductorAmpacidad;
final double conductorFinal;

//--------------------------------------
// Protecciones
//--------------------------------------

final int proteccion;
final String diferencial;

//--------------------------------------
// Caída de tensión
//--------------------------------------

final double caidaVolt;
final double caidaPorcentaje;

//--------------------------------------
// Resultado
//--------------------------------------

final bool cumple;
final String observacion;

const ElectricalProject({

required this.id,
required this.nombre,
required this.fecha,
required this.tipo,
required this.voltaje,
required this.corriente,
required this.longitud,
required this.material,
required this.sistema,
required this.conductorAmpacidad,
required this.conductorFinal,
required this.proteccion,
required this.diferencial,
required this.caidaVolt,
required this.caidaPorcentaje,
required this.cumple,
required this.observacion,

});

//--------------------------------------
// SQLite
//--------------------------------------

Map<String, dynamic> toMap() {

return {

"id": id,

"nombre": nombre,

"fecha": fecha.toIso8601String(),

"tipo": tipo,

"voltaje": voltaje,

"corriente": corriente,

"longitud": longitud,

"material": material,

"sistema": sistema,

"conductorAmpacidad": conductorAmpacidad,

"conductorFinal": conductorFinal,

"proteccion": proteccion,

"diferencial": diferencial,

"caidaVolt": caidaVolt,

"caidaPorcentaje": caidaPorcentaje,

"cumple": cumple ? 1 : 0,

"observacion": observacion,

};

}

factory ElectricalProject.fromMap(
Map<String, dynamic> map,
) {

return ElectricalProject(

id: map["id"],

nombre: map["nombre"],

fecha: DateTime.parse(
map["fecha"],
),

tipo: map["tipo"],

voltaje: (map["voltaje"] as num).toDouble(),

corriente: (map["corriente"] as num).toDouble(),

longitud: (map["longitud"] as num).toDouble(),

material: map["material"],

sistema: map["sistema"],

conductorAmpacidad:
(map["conductorAmpacidad"] as num).toDouble(),

conductorFinal:
(map["conductorFinal"] as num).toDouble(),

proteccion: map["proteccion"],

diferencial: map["diferencial"],

caidaVolt:
(map["caidaVolt"] as num).toDouble(),

caidaPorcentaje:
(map["caidaPorcentaje"] as num).toDouble(),

cumple: map["cumple"] == 1,

observacion: map["observacion"],

);

}

//--------------------------------------
// Getters
//--------------------------------------
  String get conductorTexto =>
      "${conductorFinal.toStringAsFixed(1)} mm²";

  String get ampacidadTexto =>
      "${conductorAmpacidad.toStringAsFixed(1)} mm²";

  String get voltajeTexto =>
      "${voltaje.toStringAsFixed(0)} V";

  String get corrienteTexto =>
      "${corriente.toStringAsFixed(0)} A";

  String get longitudTexto =>
      "${longitud.toStringAsFixed(0)} m";

  String get caidaTexto =>
      "${caidaVolt.toStringAsFixed(2)} V";

  String get porcentajeTexto =>
      "${caidaPorcentaje.toStringAsFixed(2)} %";

  String get proteccionTexto =>
      "$proteccion A";
}