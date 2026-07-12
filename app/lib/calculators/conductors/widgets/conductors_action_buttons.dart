import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../database/project_repository.dart';
import '../../../models/electrical_project.dart';
import '../../../services/project_factory.dart';
import '../conductors_result.dart';

class ConductorsActionButtons extends StatelessWidget {
  final ConductorsResult resultado;

  const ConductorsActionButtons({
    super.key,
    required this.resultado,
  });

  //--------------------------------------------------
  // Guardar proyecto
  //--------------------------------------------------

  Future<void> _guardarProyecto(
      BuildContext context,
      ) async {
    final controller = TextEditingController();

    final nombre = await showDialog<String>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text("Guardar proyecto"),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: const InputDecoration(
              labelText: "Nombre del proyecto",
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text("Cancelar"),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                  controller.text.trim(),
                );
              },
              child: const Text("Guardar"),
            ),
          ],
        );
      },
    );

    if (nombre == null || nombre.isEmpty) {
      return;
    }

    final ElectricalProject proyecto =
    ProjectFactory.fromConductors(
      nombre: nombre,
      resultado: resultado,
    );

    ProjectRepository.instance.guardar(
      proyecto,
    );

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Proyecto \"$nombre\" guardado correctamente.",
          ),
        ),
      );
    }
  }

  //--------------------------------------------------
  // Copiar resultado
  //--------------------------------------------------

  Future<void> _copiarResultado(
      BuildContext context,
      ) async {
    final texto = '''
CONDUCTORES PRO

Voltaje: ${resultado.voltajeTexto}

Corriente: ${resultado.corrienteTexto}

Longitud: ${resultado.longitudTexto}

Material: ${resultado.material}

Sistema: ${resultado.sistema}

Conductor: ${resultado.conductorFinalTexto}

Protección: ${resultado.proteccionTexto}

Diferencial: ${resultado.diferencial}

${resultado.estadoTexto}

${resultado.observacion}
''';

    await Clipboard.setData(
      ClipboardData(
        text: texto,
      ),
    );

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Resultado copiado al portapapeles.",
          ),
        ),
      );
    }
  }

  //--------------------------------------------------
  // Compartir (temporal)
  //--------------------------------------------------

  void _compartir(
      BuildContext context,
      ) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Compartir llegará en la siguiente versión.",
        ),
      ),
    );
  }

  //--------------------------------------------------
  // UI
  //--------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.stretch,
      children: [
        FilledButton.icon(
          onPressed: () => _guardarProyecto(context),
          icon: const Icon(Icons.save),
          label: const Text(
            "Guardar Proyecto",
          ),
        ),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          onPressed: () => _copiarResultado(context),
          icon: const Icon(Icons.copy),
          label: const Text(
            "Copiar Resultado",
          ),
        ),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          onPressed: () => _compartir(context),
          icon: const Icon(Icons.share),
          label: const Text(
            "Compartir",
          ),
        ),
      ],
    );
  }
}