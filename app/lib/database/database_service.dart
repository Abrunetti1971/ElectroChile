import '../models/electrical_project.dart';

class DatabaseService {
  DatabaseService._();

  static final DatabaseService instance =
  DatabaseService._();

  //----------------------------------------------------
  // Base de datos temporal (en memoria)
  //----------------------------------------------------

  final List<ElectricalProject> _projects = [];

  //----------------------------------------------------
  // Obtener todos los proyectos
  //----------------------------------------------------

  List<ElectricalProject> obtenerProyectos() {
    return List.unmodifiable(_projects);
  }

  //----------------------------------------------------
  // Guardar proyecto
  //----------------------------------------------------

  void guardarProyecto(
      ElectricalProject proyecto,
      ) {
    _projects.add(proyecto);
  }

  //----------------------------------------------------
  // Actualizar proyecto
  //----------------------------------------------------

  void actualizarProyecto(
      ElectricalProject proyecto,
      ) {
    final index = _projects.indexWhere(
          (p) => p.id == proyecto.id,
    );

    if (index != -1) {
      _projects[index] = proyecto;
    }
  }

  //----------------------------------------------------
  // Buscar proyecto
  //----------------------------------------------------

  ElectricalProject? buscarProyecto(
      String id,
      ) {
    try {
      return _projects.firstWhere(
            (p) => p.id == id,
      );
    } catch (_) {
      return null;
    }
  }

  //----------------------------------------------------
  // Eliminar proyecto
  //----------------------------------------------------

  void eliminarProyecto(
      String id,
      ) {
    _projects.removeWhere(
          (p) => p.id == id,
    );
  }

  //----------------------------------------------------
  // Cantidad
  //----------------------------------------------------

  int get cantidad => _projects.length;

  //----------------------------------------------------
  // Existe
  //----------------------------------------------------

  bool existe(
      String id,
      ) {
    return _projects.any(
          (p) => p.id == id,
    );
  }

  //----------------------------------------------------
  // Limpiar (pruebas)
  //----------------------------------------------------

  void limpiar() {
    _projects.clear();
  }
}