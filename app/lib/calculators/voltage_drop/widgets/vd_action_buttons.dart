import 'package:flutter/material.dart';

class VdActionButtons extends StatelessWidget {
  final VoidCallback onCalcular;
  final VoidCallback onCompartir;
  final VoidCallback onGuardar;

  const VdActionButtons({
    super.key,
    required this.onCalcular,
    required this.onCompartir,
    required this.onGuardar,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        SizedBox(
          width: double.infinity,
          height: 55,
          child: FilledButton.icon(
            onPressed: onCalcular,
            icon: const Icon(Icons.calculate),
            label: const Text(
              "CALCULAR",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        const SizedBox(height: 15),

        Row(
          children: [

            Expanded(
              child: OutlinedButton.icon(
                onPressed: onCompartir,
                icon: const Icon(Icons.share),
                label: const Text(
                  "Compartir",
                ),
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: FilledButton.icon(
                onPressed: onGuardar,
                icon: const Icon(Icons.save),
                label: const Text(
                  "Guardar",
                ),
              ),
            ),

          ],
        ),

      ],
    );
  }
}