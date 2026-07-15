import 'conductors_result.dart';
import 'conductors_types.dart';
import 'tables/ampacity_table.dart';
import 'tables/grouping_table.dart';
import 'tables/temperature_table.dart';

class ConductorsService {
ConductorsService._();

static ConductorsResult calcular({
required double voltaje,
required double corriente,
required double longitud,
required ConductorMaterial material,
required ElectricalSystem sistema,
required InstallationMethod metodo,
required InsulationType aislacion,
required double temperatura,
required int circuitosAgrupados,
}) {
final double factorTemperatura =
_obtenerFactorTemperatura(
temperatura,
);

final double factorAgrupamiento =
_obtenerFactorAgrupamiento(
circuitosAgrupados,
);

final double productoFactores =
factorTemperatura *
factorAgrupamiento;

final double corrienteCorregida =
productoFactores > 0
? corriente / productoFactores
: corriente;

final double conductorAmpacidad =
_seleccionarPorAmpacidad(
corrienteCorregida: corrienteCorregida,
material: material,
aislacion: aislacion,
);

final double conductorCaida =
_seleccionarPorCaida(
voltaje: voltaje,
corriente: corriente,
longitud: longitud,
material: material,
sistema: sistema,
);

final double conductorFinal =
conductorAmpacidad >= conductorCaida
? conductorAmpacidad
: conductorCaida;

final int proteccion =
_seleccionarProteccion(
corriente,
);

final String diferencial =
_seleccionarDiferencial(
proteccion,
);

final bool cumple =
conductorFinal > 0 &&
factorTemperatura > 0 &&
factorAgrupamiento > 0;

final String observacion =
_generarObservacion(
conductorAmpacidad:
conductorAmpacidad,
conductorCaida:
conductorCaida,
conductorFinal:
conductorFinal,
corrienteCorregida:
corrienteCorregida,
factorTemperatura:
factorTemperatura,
factorAgrupamiento:
factorAgrupamiento,
cumple:
cumple,
);

return ConductorsResult(
voltaje: voltaje,
corriente: corriente,
longitud: longitud,
material: _materialTexto(material),
sistema: _sistemaTexto(sistema),
metodoInstalacion:
_metodoTexto(metodo),
aislacion:
_aislacionTexto(aislacion),
temperatura: temperatura,
circuitosAgrupados:
circuitosAgrupados,
factorTemperatura:
factorTemperatura,
factorAgrupamiento:
factorAgrupamiento,
conductorAmpacidad:
conductorAmpacidad,
conductorCaida:
conductorCaida,
conductorFinal:
conductorFinal,
proteccion:
proteccion,
diferencial:
diferencial,
cumple:
cumple,
observacion:
observacion,
);
}
//--------------------------------------------------
// FACTOR TEMPERATURA
//--------------------------------------------------

static double _obtenerFactorTemperatura(
double temperatura,
) {
for (final fila in TemperatureTable.rows) {
if (fila.temperature == temperatura.round()) {
return fila.factor;
}
}

return 1.0;
}

//--------------------------------------------------
// FACTOR AGRUPAMIENTO
//--------------------------------------------------

static double _obtenerFactorAgrupamiento(
int circuitos,
) {
if (circuitos <= 1) {
return 1.0;
}

final int cantidad =
circuitos > 5 ? 5 : circuitos;

for (final fila in GroupingTable.rows) {
if (fila.circuits == cantidad) {
return fila.factor;
}
}

return 1.0;
}

//--------------------------------------------------
// SELECCIÓN POR AMPACIDAD
//--------------------------------------------------

static double _seleccionarPorAmpacidad({

required double corrienteCorregida,

required ConductorMaterial material,

required InsulationType aislacion,

}) {

for (final fila in AmpacityTable.rows) {

int ampacidad;

if (material == ConductorMaterial.aluminio) {

ampacidad = fila.aluminium;

} else {

switch (aislacion) {

case InsulationType.pvc:
ampacidad = fila.pvc;
break;

case InsulationType.xlpe:
ampacidad = fila.xlpe;
break;

case InsulationType.epr:
ampacidad = fila.xlpe;
break;

}

}

if (corrienteCorregida <= ampacidad) {
return fila.section;
}

}

return AmpacityTable.rows.last.section;

}
//--------------------------------------------------
// SELECCIÓN POR CAÍDA DE TENSIÓN
//--------------------------------------------------

static double _seleccionarPorCaida({

required double voltaje,

required double corriente,

required double longitud,

required ConductorMaterial material,

required ElectricalSystem sistema,

}) {

const double resistividadCobre = 0.0175;
const double resistividadAluminio = 0.0282;

final double rho =
material == ConductorMaterial.cobre
? resistividadCobre
: resistividadAluminio;

const double caidaMaxima = 0.03;

final double deltaV =
voltaje * caidaMaxima;

double seccionCalculada;

if (sistema == ElectricalSystem.monofasico) {

seccionCalculada =
(2 *
rho *
longitud *
corriente) /
deltaV;

} else {

seccionCalculada =
(1.732 *
rho *
longitud *
corriente) /
deltaV;

}

for (final fila in AmpacityTable.rows) {

if (fila.section >= seccionCalculada) {
return fila.section;
}

}

return AmpacityTable.rows.last.section;

}

//--------------------------------------------------
// PROTECCIÓN AUTOMÁTICA
//--------------------------------------------------

static int _seleccionarProteccion(
double corriente,
) {

const List<int> protecciones = [

2,
4,
6,
10,
16,
20,
25,
32,
40,
50,
63,
80,
100,
125,
160,
200,
250,

];

for (final valor in protecciones) {

if (corriente <= valor) {
return valor;
}

}

return protecciones.last;

}

//--------------------------------------------------
// DIFERENCIAL
//--------------------------------------------------

static String _seleccionarDiferencial(
int proteccion,
) {

if (proteccion <= 32) {
return "30 mA";
}

return "300 mA";

}
  //--------------------------------------------------
  // OBSERVACIONES
  //--------------------------------------------------

  static String _generarObservacion({

    required double conductorAmpacidad,

    required double conductorCaida,

    required double conductorFinal,

    required double corrienteCorregida,

    required double factorTemperatura,

    required double factorAgrupamiento,

    required bool cumple,

  }) {

    if (!cumple) {
      return "El conductor seleccionado no cumple los criterios de diseño.";
    }

    if (conductorFinal == conductorCaida) {
      return "La caída de tensión determina la sección final del conductor.";
    }

    if (conductorFinal == conductorAmpacidad) {
      return "La ampacidad determina la sección final del conductor.";
    }

    return "Selección realizada correctamente.";

  }

  //--------------------------------------------------
  // CONVERSORES DE TEXTO
  //--------------------------------------------------

  static String _materialTexto(
      ConductorMaterial material,
      ) {

    switch (material) {

      case ConductorMaterial.cobre:
        return "Cobre";

      case ConductorMaterial.aluminio:
        return "Aluminio";

    }

  }

  static String _sistemaTexto(
      ElectricalSystem sistema,
      ) {

    switch (sistema) {

      case ElectricalSystem.monofasico:
        return "Monofásico";

      case ElectricalSystem.trifasico:
        return "Trifásico";

    }

  }

  static String _metodoTexto(
      InstallationMethod metodo,
      ) {

    switch (metodo) {

      case InstallationMethod.ductoPvc:
        return "Ducto PVC";

      case InstallationMethod.ductoMetalico:
        return "Ducto Metálico";

      case InstallationMethod.bandejaPerforada:
        return "Bandeja Perforada";

      case InstallationMethod.bandejaEscalera:
        return "Bandeja Escalera";

      case InstallationMethod.embutido:
        return "Embutido";

      case InstallationMethod.enterrado:
        return "Enterrado";

      case InstallationMethod.aireLibre:
        return "Aire Libre";

    }

  }

  static String _aislacionTexto(
      InsulationType aislacion,
      ) {

    switch (aislacion) {

      case InsulationType.pvc:
        return "PVC";

      case InsulationType.xlpe:
        return "XLPE";

      case InsulationType.epr:
        return "EPR";

    }

  }

}