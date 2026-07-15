import 'voltage_drop_result.dart';

class VoltageDropService {

//====================================================
// Resistividad
//====================================================

static double resistividad({
required bool cobre,
}) {

return cobre ? 0.0175 : 0.0282;

}

//====================================================
// Monofásico
//====================================================

static double calcularMonofasico({

required double longitud,

required double corriente,

required double seccion,

required bool cobre,

}) {

final rho = resistividad(
cobre: cobre,
);

return (2 * rho * longitud * corriente) /
seccion;

}

//====================================================
// Trifásico
//====================================================

static double calcularTrifasico({

required double longitud,

required double corriente,

required double seccion,

required bool cobre,

}) {

final rho = resistividad(
cobre: cobre,
);

return (1.732 * rho * longitud * corriente) /
seccion;

}

//====================================================
// %
//====================================================

static double porcentaje({

required double caidaVolt,

required double voltaje,

}) {

return (caidaVolt / voltaje) * 100;

}

//====================================================
// TABLAS
//====================================================

static final Map<double,double> ampacidadCu = {

1.5:13,

2.5:18,

4:24,

6:31,

10:43,

16:57,

25:76,

35:96,

50:116,

70:148,

95:180,

120:208,

};

static final Map<double,double> ampacidadAl = {

16:50,

25:65,

35:80,

50:100,

70:125,

95:150,

120:175,

};

//====================================================
// Protección
//====================================================

static int proteccion({

required double corriente,

}) {

if(corriente<=10) return 10;

if(corriente<=16) return 16;

if(corriente<=20) return 20;

if(corriente<=25) return 25;

if(corriente<=32) return 32;

if(corriente<=40) return 40;

if(corriente<=50) return 50;

if(corriente<=63) return 63;

return 80;

}

//====================================================
// Diferencial
//====================================================

static String diferencial(int proteccion){

if(proteccion<=20){

return "25 A / 30 mA";

}

if(proteccion<=40){

return "40 A / 30 mA";

}

if(proteccion<=63){

return "63 A / 30 mA";

}

return "80 A / 30 mA";

}

//====================================================
// Motor principal
//====================================================

static VoltageDropResult calcular({

required double voltaje,

required double corriente,

required double longitud,

required bool cobre,

required bool trifasico,

}){

final Map<double,double> tabla =

cobre

? ampacidadCu

: ampacidadAl;

double seccionAmpacidad =

tabla.keys.first;

double seccionFinal =

tabla.keys.last;
//--------------------------------------------------
// Sección mínima por ampacidad
//--------------------------------------------------

for (final item in tabla.entries) {

  if (corriente <= item.value) {

    seccionAmpacidad = item.key;

    break;

  }

}

//--------------------------------------------------
// Buscar la primera sección que cumpla
// ampacidad + caída <= 3 %
//--------------------------------------------------

for (final item in tabla.entries) {

  if (corriente > item.value) {
    continue;
  }

  final double caida = trifasico

      ? calcularTrifasico(
    longitud: longitud,
    corriente: corriente,
    seccion: item.key,
    cobre: cobre,
  )

      : calcularMonofasico(
    longitud: longitud,
    corriente: corriente,
    seccion: item.key,
    cobre: cobre,
  );

  final double porcentajeCaida =
  porcentaje(
    caidaVolt: caida,
    voltaje: voltaje,
  );

  if (porcentajeCaida <= 3) {

    seccionFinal = item.key;

    break;

  }

}

//--------------------------------------------------
// Resultado definitivo
//--------------------------------------------------

final double caida = trifasico

    ? calcularTrifasico(
  longitud: longitud,
  corriente: corriente,
  seccion: seccionFinal,
  cobre: cobre,
)

    : calcularMonofasico(
  longitud: longitud,
  corriente: corriente,
  seccion: seccionFinal,
  cobre: cobre,
);

final double porcentajeFinal =
porcentaje(
  caidaVolt: caida,
  voltaje: voltaje,
);

final int proteccionCalculada =
proteccion(
  corriente: corriente,
);

final bool aumento =
    seccionFinal > seccionAmpacidad;

final String observacion;

if (aumento) {

  observacion =
  "La sección mínima por ampacidad es "
      "${seccionAmpacidad.toStringAsFixed(1)} mm². "
      "Debido a la longitud del circuito "
      "(${longitud.toStringAsFixed(0)} m), "
      "fue necesario aumentar la sección hasta "
      "${seccionFinal.toStringAsFixed(1)} mm² "
      "para mantener una caída de tensión de "
      "${porcentajeFinal.toStringAsFixed(2)} %, "
      "cumpliendo el límite recomendado del 3 %.";

} else {

  observacion =
  "La sección de "
      "${seccionFinal.toStringAsFixed(1)} mm² "
      "cumple simultáneamente con la ampacidad "
      "requerida y el límite máximo de caída "
      "de tensión del 3 %.";

}

return VoltageDropResult(

  voltaje: voltaje,

  corriente: corriente,

  longitud: longitud,

  cobre: cobre,

  trifasico: trifasico,

  conductorAmpacidad: seccionAmpacidad,

  conductor: seccionFinal,

  proteccion: proteccionCalculada,

  diferencial: diferencial(
    proteccionCalculada,
  ),

  caidaVolt: caida,

  caidaPorcentaje: porcentajeFinal,

  cumple: porcentajeFinal <= 3,

  observacion: observacion,

);

}

}