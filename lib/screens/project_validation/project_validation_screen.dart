import 'package:flutter/material.dart';

import '../../models/project.dart';
import '../../services/project_engine.dart';

class ProjectValidationScreen extends StatelessWidget {
  final Project project;
  final ProjectEngine engine;

  const ProjectValidationScreen({
    super.key,
    required this.project,
    required this.engine,
  });

  @override
  Widget build(BuildContext context) {
    final validations = engine.validations;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Centro de Validación SEC'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: ListTile(
                title: Text(project.name),
                subtitle: Text(
                  '${engine.circuitCount} circuitos',
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${engine.compliance.toStringAsFixed(0)}%',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      engine.isValid
                          ? 'APTO'
                          : 'REVISAR',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: validations.isEmpty
                  ? const Center(
                child: Text(
                  'No existen observaciones.',
                ),
              )
                  : ListView.builder(
                itemCount: validations.length,
                itemBuilder: (context, index) {
                  final item = validations[index];

                  IconData icon;
                  Color color;

                  if (item.isPassed) {
                    icon = Icons.check_circle;
                    color = Colors.green;
                  } else if (item.isWarning) {
                    icon = Icons.warning;
                    color = Colors.orange;
                  } else {
                    icon = Icons.error;
                    color = Colors.red;
                  }

                  return Card(
                    child: ListTile(
                      leading: Icon(
                        icon,
                        color: color,
                      ),
                      title: Text(
                        '${item.code} - ${item.title}',
                      ),
                      subtitle: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(item.description),
                          const SizedBox(height: 6),
                          Text(
                            'Norma: ${item.regulation}',
                            style: const TextStyle(
                              fontWeight:
                              FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Recomendación:',
                            style: const TextStyle(
                              fontWeight:
                              FontWeight.bold,
                            ),
                          ),
                          Text(
                            item.recommendation,
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
      ),
    );
  }
}