import '../models/project.dart';

/// Repositorio oficial de proyectos.
///
/// Actualmente trabaja en memoria.
///
/// En la siguiente etapa será reemplazado por SQLite
/// sin modificar ninguna pantalla.
class ProjectRepository {
  final List<Project> _projects = [];

  /// Devuelve todos los proyectos.
  List<Project> getAll() {
    return List.unmodifiable(_projects);
  }

  /// Devuelve un proyecto por su ID.
  Project? getById(String id) {
    try {
      return _projects.firstWhere(
            (project) => project.id == id,
      );
    } catch (_) {
      return null;
    }
  }

  /// Agrega un nuevo proyecto.
  void add(Project project) {
    _projects.add(project);
  }

  /// Actualiza un proyecto existente.
  bool update(Project project) {
    final index = _projects.indexWhere(
          (item) => item.id == project.id,
    );

    if (index == -1) {
      return false;
    }

    _projects[index] = project;

    return true;
  }

  /// Elimina un proyecto.
  bool delete(String id) {
    final before = _projects.length;

    _projects.removeWhere(
          (project) => project.id == id,
    );

    return before != _projects.length;
  }

  /// Elimina todos los proyectos.
  void clear() {
    _projects.clear();
  }

  /// Cantidad de proyectos.
  int get count => _projects.length;

  /// Indica si existen proyectos.
  bool get isEmpty => _projects.isEmpty;

  bool get isNotEmpty => _projects.isNotEmpty;

  /// Comprueba si existe un proyecto
  /// con el mismo nombre.
  bool existsByName(String name) {
    return _projects.any(
          (project) =>
      project.name.trim().toLowerCase() ==
          name.trim().toLowerCase(),
    );
  }

  /// Busca proyectos por texto.
  List<Project> search(String text) {
    final query = text.trim().toLowerCase();

    if (query.isEmpty) {
      return getAll();
    }

    return _projects.where((project) {
      return project.name.toLowerCase().contains(query) ||
          project.client.toLowerCase().contains(query) ||
          project.address.toLowerCase().contains(query) ||
          project.city.toLowerCase().contains(query);
    }).toList();
  }

  /// Ordena los proyectos por nombre.
  void sortByName() {
    _projects.sort(
          (a, b) => a.name.compareTo(b.name),
    );
  }

  /// Ordena por fecha de creación.
  void sortByDate() {
    _projects.sort(
          (a, b) => b.createdAt.compareTo(a.createdAt),
    );
  }
}