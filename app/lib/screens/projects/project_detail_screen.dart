import 'package:flutter/material.dart';

import '../../components/ec_data_row.dart';
import '../../components/ec_section_card.dart';
import '../../components/ec_status_chip.dart';
import '../../models/project.dart';

class ProjectDetailScreen extends StatelessWidget {
  final Project project;

  const ProjectDetailScreen({
    super.key,
    required this.project,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(project.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            EcSectionCard(
              titulo: "Información General",
              icon: Icons.folder,
              child: Column(
                children: [
                  EcDataRow(
                    icon: Icons.folder,
                    label: "Proyecto",
                    value: project.name,
                  ),
                  EcDataRow(
                    icon: Icons.person,
                    label: "Cliente",
                    value: project.clientDisplay,
                  ),
                  EcDataRow(
                    icon: Icons.location_on,
                    label: "Dirección",
                    value: project.fullAddress,
                  ),
                  EcDataRow(
                    icon: Icons.business,
                    label: "Distribuidora",
                    value: project.distributorDisplay,
                  ),
                ],
              ),
            ),

            EcSectionCard(
              titulo: "Estado",
              icon: Icons.verified,
              child: Align(
                alignment: Alignment.centerLeft,
                child: EcStatusChip(
                  texto: "Proyecto Activo",
                  tipo: EcStatusType.success,
                ),
              ),
            ),

            EcSectionCard(
              titulo: "Observaciones",
              icon: Icons.description,
              child: Text(
                project.notes.isEmpty
                    ? "Sin observaciones."
                    : project.notes,
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.5,
                ),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: FilledButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Módulo Circuitos disponible próximamente.",
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.electrical_services),
                label: const Text(
                  "Circuitos",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Edición disponible próximamente.",
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.edit),
                label: const Text("Editar Proyecto"),
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Exportación PDF disponible próximamente.",
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.picture_as_pdf),
                label: const Text("Generar PDF"),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}