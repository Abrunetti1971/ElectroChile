import 'package:flutter/material.dart';

import '../../models/project.dart';
import '../../repositories/project_repository.dart';
import '../../services/project_service.dart';
import 'project_detail_screen.dart';
import 'project_form_dialog.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  static final ProjectRepository _repository =
  ProjectRepository();

  late final ProjectService _service;

  final TextEditingController _searchController =
  TextEditingController();

  List<Project> _projects = [];

  bool _loading = true;
  String _searchText = '';

  @override
  void initState() {
    super.initState();

    _service = ProjectService(_repository);

    _loadProjects();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadProjects() async {
    try {
      final data = _searchText.trim().isEmpty
          ? await _service.getProjects()
          : await _service.searchProjects(_searchText);

      if (!mounted) return;

      setState(() {
        _projects = data;
        _loading = false;
      });
    } catch (error) {
      if (!mounted) return;

      setState(() {
        _loading = false;
      });

      _showMessage(
        'No fue posible cargar los proyectos.',
        isError: true,
      );
    }
  }

  Future<void> _searchProjects(String value) async {
    _searchText = value.trim();

    setState(() {
      _loading = true;
    });

    await _loadProjects();
  }

  Future<void> _newProject() async {
    final result =
    await showModalBottomSheet<Map<String, String>>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => const ProjectFormDialog(),
    );

    if (result == null) return;

    final name = result['name']?.trim() ?? '';

    if (name.isEmpty) return;

    try {
      await _service.createProject(
        name: name,
        client: result['client']?.trim() ?? '',
        address: result['address']?.trim() ?? '',
        city: result['city']?.trim() ?? '',
        region: result['region']?.trim() ?? '',
        distributor:
        result['distributor']?.trim() ?? '',
        notes: result['notes']?.trim() ?? '',
      );

      _searchController.clear();
      _searchText = '';

      await _loadProjects();

      if (!mounted) return;

      _showMessage('Proyecto "$name" creado.');
    } catch (error) {
      if (!mounted) return;

      _showMessage(
        'No fue posible crear el proyecto.',
        isError: true,
      );
    }
  }

  Future<void> _openProject(Project project) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProjectDetailScreen(
          project: project,
        ),
      ),
    );

    await _loadProjects();
  }

  Future<void> _confirmDelete(Project project) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Eliminar proyecto'),
          content: Text(
            '¿Deseas eliminar "${project.name}"?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );

    if (confirmed != true) return;

    try {
      await _service.deleteProject(project.id);
      await _loadProjects();

      if (!mounted) return;

      _showMessage('Proyecto eliminado.');
    } catch (error) {
      if (!mounted) return;

      _showMessage(
        'No fue posible eliminar el proyecto.',
        isError: true,
      );
    }
  }

  void _showMessage(
      String message, {
        bool isError = false,
      }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor:
        isError ? Colors.red.shade700 : null,
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mis Proyectos"),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _newProject,
        icon: const Icon(Icons.add),
        label: const Text("Nuevo"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Buscar proyecto...",
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isEmpty
                    ? null
                    : IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    _searchProjects('');
                    setState(() {});
                  },
                ),
              ),
              onChanged: (value) {
                setState(() {});
                _searchProjects(value);
              },
            ),
          ),
          Expanded(
            child: _loading
                ? const Center(
              child: CircularProgressIndicator(),
            )
                : _projects.isEmpty
                ? const Center(
              child: Text(
                "No existen proyectos.\n\nPresione NUEVO para crear uno.",
                textAlign: TextAlign.center,
              ),
            )
                : RefreshIndicator(
              onRefresh: _loadProjects,
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _projects.length,
                itemBuilder: (_, index) {
                  final project = _projects[index];

                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text("${index + 1}"),
                      ),
                      title: Text(
                        project.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        project.client.isEmpty
                            ? "Sin cliente"
                            : project.client,
                      ),
                      onTap: () => _openProject(project),
                      trailing: PopupMenuButton<String>(
                        onSelected: (value) {
                          switch (value) {
                            case 'open':
                              _openProject(project);
                              break;

                            case 'delete':
                              _confirmDelete(project);
                              break;
                          }
                        },
                        itemBuilder: (_) => const [
                          PopupMenuItem(
                            value: 'open',
                            child: Row(
                              children: [
                                Icon(Icons.folder_open),
                                SizedBox(width: 10),
                                Text("Abrir"),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: 'delete',
                            child: Row(
                              children: [
                                Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "Eliminar",
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}