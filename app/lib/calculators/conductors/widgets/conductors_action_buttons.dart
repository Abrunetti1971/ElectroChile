import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../models/project.dart';
import '../../../repositories/project_repository.dart';
import '../conductors_result.dart';

class ConductorsActionButtons extends StatelessWidget {
  ConductorsActionButtons({
    super.key,
    required this.resultado,
  });

  final ConductorsResult resultado;

  final ProjectRepository repository =
      ProjectRepository.instance;

  Future<void> _guardarProyecto(
      BuildContext context) async {
    final controller = TextEditingController();

    final nombre = await showDialog<String>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Guardar proyecto"),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(
            labelText: "Nombre",
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar"),
          ),
          FilledButton(
            onPressed: () =>
                Navigator.pop(context, controller.text),
            child: const Text("Guardar"),
          ),
        ],
      ),
    );

    if (nombre == null || nombre.trim().isEmpty) {
      return;
    }

    repository.add(
      Project(
        id: DateTime.now()
            .millisecondsSinceEpoch
            .toString(),
        name: nombre,
        client: "",
        address: "",
        city: "",
        createdAt: DateTime.now(),
      ),
    );

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Proyecto "$nombre" guardado.',
          ),
        ),
      );
    }
  }

  Future<void> _copiarResultado(
      BuildContext context) async {
    await Clipboard.setData(
      ClipboardData(
        text: resultado.toString(),
      ),
    );

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Resultado copiado."),
        ),
      );
    }
  }

  void _compartir(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Compartir estará disponible próximamente.",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.stretch,
      children: [
        FilledButton.icon(
          onPressed: () =>
              _guardarProyecto(context),
          icon: const Icon(Icons.save),
          label:
          const Text("Guardar Proyecto"),
        ),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          onPressed: () =>
              _copiarResultado(context),
          icon: const Icon(Icons.copy),
          label:
          const Text("Copiar Resultado"),
        ),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          onPressed: () =>
              _compartir(context),
          icon: const Icon(Icons.share),
          label: const Text("Compartir"),
        ),
      ],
    );
  }
}