import 'package:flutter/material.dart';

import '../../components/ec_data_row.dart';
import '../../components/ec_section_card.dart';
import '../../components/ec_status_chip.dart';
import '../../models/electrical_project.dart';
import '../../services/share_service.dart';

class ProjectDetailScreen extends StatelessWidget {
final ElectricalProject proyecto;

const ProjectDetailScreen({
super.key,
required this.proyecto,
});

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: Text(proyecto.nombre),
),
body: SingleChildScrollView(
padding: const EdgeInsets.all(20),
child: Column(
children: [

EcSectionCard(
titulo: "Información del Proyecto",
icon: Icons.folder,
child: Column(
children: [

EcDataRow(
icon: Icons.folder,
label: "Nombre",
value: proyecto.nombre,
),

EcDataRow(
icon: Icons.calendar_month,
label: "Fecha",
value: proyecto.fecha.toString(),
),

EcDataRow(
icon: Icons.electrical_services,
label: "Tipo",
value: proyecto.tipo,
),

],
),
),

EcSectionCard(
titulo: "Datos Eléctricos",
icon: Icons.bolt,
child: Column(
children: [

EcDataRow(
icon: Icons.bolt,
label: "Voltaje",
value: proyecto.voltajeTexto,
),

EcDataRow(
icon: Icons.electric_bolt,
label: "Corriente",
value: proyecto.corrienteTexto,
),

EcDataRow(
icon: Icons.straighten,
label: "Longitud",
value: proyecto.longitudTexto,
),

EcDataRow(
icon: Icons.cable,
label: "Conductor",
value: proyecto.conductorTexto,
),

EcDataRow(
icon: Icons.security,
label: "Protección",
value: proyecto.proteccionTexto,
),

EcDataRow(
icon: Icons.health_and_safety,
label: "Diferencial",
value: proyecto.diferencial,
),

EcDataRow(
icon: Icons.trending_down,
label: "Caída",
value: proyecto.caidaTexto,
),

EcDataRow(
icon: Icons.percent,
label: "Porcentaje",
value: proyecto.porcentajeTexto,
),

],
),
),

EcSectionCard(
titulo: "Estado del Proyecto",
icon: Icons.verified,
child: Align(
alignment: Alignment.centerLeft,
child: EcStatusChip(
texto: proyecto.cumple
? "Cumple SEC"
: "No cumple SEC",
tipo: proyecto.cumple
? EcStatusType.success
: EcStatusType.error,
),
),
),

EcSectionCard(
titulo: "Observaciones",
icon: Icons.description,
child: Text(
proyecto.observacion.isEmpty
? "Sin observaciones registradas."
: proyecto.observacion,
style: const TextStyle(
fontSize: 15,
height: 1.5,
),
),
),
  //--------------------------------------------------
  // Acciones
  //--------------------------------------------------

  SizedBox(
    width: double.infinity,
    height: 50,
    child: FilledButton.icon(
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Edición de proyecto disponible próximamente.",
            ),
          ),
        );
      },
      icon: const Icon(Icons.edit),
      label: const Text(
        "Editar Proyecto",
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
      onPressed: () async {
        await ShareService.compartirProyecto(
          proyecto,
        );
      },
      icon: const Icon(Icons.share),
      label: const Text(
        "Compartir",
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
              "Generación de PDF disponible próximamente.",
            ),
          ),
        );
      },
      icon: const Icon(Icons.picture_as_pdf),
      label: const Text(
        "Generar PDF",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ),

  const SizedBox(height: 30),

],
),
),
);
}
}