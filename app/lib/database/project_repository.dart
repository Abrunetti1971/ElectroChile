import '../models/electrical_project.dart';
import 'database_service.dart';

class ProjectRepository {
  ProjectRepository._();

  static final ProjectRepository instance =
  ProjectRepository._();

  final DatabaseService _database =
      DatabaseService.instance;

  //--------------------------------------------------
  // Obtener todos los proyectos
  //--------------------------------------------------

  List<ElectricalProject> obtenerTodos() {
    return _database.obtenerProyectos();
  }

  //--------------------------------------------------
  // Buscar proyecto
  //--------------------------------------------------

  ElectricalProject? buscarPorId(
      String id,
      ) {
    return _database.buscarProyecto(id);
  }

  //--------------------------------------------------
  // Guardar proyecto
  //--------------------------------------------------

  void guardar(
      ElectricalProject proyecto,
      ) {
    _database.guardarProyecto(proyecto);
  }

  //--------------------------------------------------
  // Actualizar proyecto
  //--------------------------------------------------

  void actualizar(
      ElectricalProject proyecto,
      ) {
    _database.actualizarProyecto(proyecto);
  }

  //--------------------------------------------------
  // Eliminar proyecto
  //--------------------------------------------------

  void eliminar(
      String id,
      ) {
    _database.eliminarProyecto(id);
  }

  //--------------------------------------------------
  // Cantidad
  //--------------------------------------------------

  int get cantidad =>
      _database.cantidad;

  //--------------------------------------------------
  // Limpiar
  //--------------------------------------------------

  void limpiar() {
    _database.limpiar();
  }
}