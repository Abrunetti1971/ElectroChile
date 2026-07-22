import 'package:flutter/material.dart';

import '../../database/circuit_dao.dart';
import '../../models/project.dart';
import '../circuits/circuits_screen.dart';
import '../feeders/feeders_screen.dart';
import '../load_summary/load_summary_screen.dart';
import '../sec/project_validation_screen.dart';

class ProjectDetailScreen extends StatelessWidget {
  final Project project;

  const ProjectDetailScreen({
    super.key,
    required this.project,
  });

  Widget _row(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey)),
                const SizedBox(height: 2),
                Text(value.isEmpty ? '-' : value,
                    style: const TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _button(BuildContext context,
      {required IconData icon,
      required String text,
      required VoidCallback onPressed}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: SizedBox(
        width: double.infinity,
        child: FilledButton.icon(
          onPressed: onPressed,
          icon: Icon(icon),
          label: Text(text),
        ),
      ),
    );
  }

  Future<void> _showLoadSummary(BuildContext context) async {
    final circuits = await CircuitDao.instance.getByProject(project.id);

    if (!context.mounted) return;

    if (circuits.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('El proyecto no tiene circuitos.'),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LoadSummaryScreen(
          project: project,
          circuits: circuits,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(project.name)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                children: [
                  _row(Icons.person, 'Cliente', project.client),
                  _row(Icons.home, 'Dirección', project.address),
                  _row(Icons.location_city, 'Comuna', project.city),
                  _row(Icons.map, 'Región', project.region),
                  _row(Icons.bolt, 'Distribuidora', project.distributor),
                  _row(Icons.notes, 'Observaciones', project.notes),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          _button(
            context,
            icon: Icons.electrical_services,
            text: 'Circuitos',
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CircuitsScreen(project: project),
              ),
            ),
          ),
          _button(
            context,
            icon: Icons.table_chart,
            text: 'Cuadro de Cargas',
            onPressed: () => _showLoadSummary(context),
          ),
          _button(
            context,
            icon: Icons.dashboard,
            text: 'Tableros',
            onPressed: () {},
          ),
          _button(
            context,
            icon: Icons.power,
            text: 'Alimentadores',
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => FeedersScreen(project: project),
              ),
            ),
          ),
          _button(
            context,
            icon: Icons.verified_user,
            text: 'Centro de Validación SEC',
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ProjectValidationScreen(),
              ),
            ),
          ),
          _button(
            context,
            icon: Icons.assignment,
            text: 'Declaraciones SEC',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Disponible próximamente.'),
                ),
              );
            },
          ),
          _button(
            context,
            icon: Icons.picture_as_pdf,
            text: 'Generar PDF',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
