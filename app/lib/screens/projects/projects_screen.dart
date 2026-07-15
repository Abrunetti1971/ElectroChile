import 'package:flutter/material.dart';

import '../../models/project.dart';
import '../../repositories/project_repository.dart';
import '../../services/project_service.dart';
import '../../widgets/project_form_dialog.dart';
import '../circuits/circuits_screen.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  final ProjectRepository _repository = ProjectRepository.instance;
  late final ProjectService _service;

  @override
  void initState() {
    super.initState();
    _service = ProjectService(_repository);
  }

  Future<void> _newProject() async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      builder: (_) => const ProjectFormDialog(),
    );

    if (result == null) return;

    _service.createProject(
      name: result["name"] ?? "",
      client: result["client"] ?? "",
      address: result["address"] ?? "",
      city: result["city"] ?? "",
    );

    setState(() {});
  }

  void _deleteProject(Project project) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Eliminar proyecto"),
        content: Text(
          "¿Desea eliminar el proyecto '${project.name}'?",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar"),
          ),
          FilledButton(
            onPressed: () {
              _service.deleteProject(project.id);
              Navigator.pop(context);
              setState(() {});
            },
            child: const Text("Eliminar"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final projects = _service.getProjects();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mis proyectos"),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _newProject,
        icon: const Icon(Icons.add),
        label: const Text("Nuevo"),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            color: Colors.blue.shade50,
            child: Text(
              "Proyectos registrados: ${projects.length}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: projects.isEmpty
                ? const Center(
              child: Text(
                "No existen proyectos.\n\nPresione NUEVO para comenzar.",
                textAlign: TextAlign.center,
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: projects.length,
              itemBuilder: (_, index) {
                final project = projects[index];

                return Card(
                  elevation: 3,
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
                    subtitle: Text(project.clientDisplay),
                    trailing: PopupMenuButton<String>(
                      onSelected: (value) {
                        switch (value) {
                          case "open":
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => CircuitsScreen(
                                  projectId: project.id,
                                  projectName: project.name,
                                ),
                              ),
                            );
                            break;

                          case "delete":
                            _deleteProject(project);
                            break;
                        }
                      },
                      itemBuilder: (_) => const [
                        PopupMenuItem(
                          value: "open",
                          child: Text("Abrir"),
                        ),
                        PopupMenuItem(
                          value: "delete",
                          child: Text("Eliminar"),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}