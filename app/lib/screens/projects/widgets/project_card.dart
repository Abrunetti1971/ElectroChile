import 'package:flutter/material.dart';

import '../../../models/project.dart';

class ProjectCard extends StatelessWidget {
  final Project project;

  final VoidCallback onTap;
  final VoidCallback onDelete;
  final VoidCallback onShare;

  const ProjectCard({
    super.key,
    required this.project,
    required this.onTap,
    required this.onDelete,
    required this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.only(bottom: 18),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 26,
                child: Icon(Icons.folder),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      project.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(project.client),
                    const SizedBox(height: 4),
                    Text(project.address),
                    const SizedBox(height: 4),
                    Text(project.city),
                  ],
                ),
              ),
              PopupMenuButton<int>(
                onSelected: (value) {
                  switch (value) {
                    case 1:
                      onShare();
                      break;
                    case 2:
                      onDelete();
                      break;
                  }
                },
                itemBuilder: (_) => const [
                  PopupMenuItem(
                    value: 1,
                    child: Row(
                      children: [
                        Icon(Icons.share),
                        SizedBox(width: 10),
                        Text("Compartir"),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 2,
                    child: Row(
                      children: [
                        Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Eliminar",
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}