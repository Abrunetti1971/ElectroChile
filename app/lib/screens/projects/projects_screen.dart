import 'package:flutter/material.dart';

import '../../models/project.dart';
import '../../repositories/project_repository.dart';
import '../../services/project_service.dart';
import '../../widgets/project_form_dialog.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  late final ProjectRepository _repository;
  late final ProjectService _service;

  @override
  void initState() {
    super.initState();

    _repository = ProjectRepository();
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
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final projects = _service.getProjects();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mis Proyectos"),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _newProject,
        icon: const Icon(Icons.add),
        label: const Text("Nuevo"),
      ),
      body: projects.isEmpty
          ? const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.folder_open,
              size: 90,
              color: Colors.grey,
            ),
            SizedBox(height: 20),
            Text(
              "Aún no existen proyectos",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Pulsa el botón Nuevo para crear tu primer proyecto.",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: projects.length,
        itemBuilder: (context, index) {
          final Project project = projects[index];

          return Card(
            child: ListTile(
              leading: const CircleAvatar(
                child: Icon(Icons.electrical_services),
              ),
              title: Text(project.name),
              subtitle: Text(
                project.client.isEmpty
                    ? "Sin cliente"
                    : project.client,
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Abrir proyecto: ${project.name}",
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}