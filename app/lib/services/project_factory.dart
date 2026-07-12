import '../calculators/conductors/conductors_result.dart';
import '../calculators/voltage_drop/voltage_drop_result.dart';
import '../models/electrical_project.dart';

class ProjectFactory {
  ProjectFactory._();

  //----------------------------------------------------
  // Proyecto desde Caída de Tensión
  //----------------------------------------------------

  static ElectricalProject fromVoltageDrop({
    required String nombre,
    required VoltageDropResult resultado,
  }) {
    return ElectricalProject(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      nombre: nombre,
      fecha: DateTime.now(),
      tipo: "Caída de Tensión",
      voltaje: resultado.voltaje,
      corriente: resultado.corriente,
      longitud: resultado.longitud,
      material: resultado.material,
      sistema: resultado.sistema,
      conductorAmpacidad: resultado.conductorAmpacidad,
      conductorFinal: resultado.conductor,
      proteccion: resultado.proteccion,
      diferencial: resultado.diferencial,
      caidaVolt: resultado.caidaVolt,
      caidaPorcentaje: resultado.caidaPorcentaje,
      cumple: resultado.cumple,
      observacion: resultado.observacion,
    );
  }

  //----------------------------------------------------
  // Proyecto desde Conductores
  //----------------------------------------------------

  static ElectricalProject fromConductors({
    required String nombre,
    required ConductorsResult resultado,
  }) {
    return ElectricalProject(
      id: DateTime.now().microsecondsSinceEpoch.toString(),

      nombre: nombre,

      fecha: DateTime.now(),

      tipo: "Conductores",

      voltaje: resultado.voltaje,

      corriente: resultado.corriente,

      longitud: resultado.longitud,

      material: resultado.material,

      sistema: resultado.sistema,

      conductorAmpacidad: resultado.conductorAmpacidad,

      conductorFinal: resultado.conductorFinal,

      proteccion: resultado.proteccion,

      diferencial: resultado.diferencial,

      // En esta versión aún no almacenamos
      // la caída de tensión calculada.
      caidaVolt: 0,

      caidaPorcentaje: 0,

      cumple: resultado.cumple,

      observacion: resultado.observacion,
    );
  }
}