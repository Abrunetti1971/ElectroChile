import 'package:flutter/material.dart';

import '../voltage_drop_result.dart';

class VdResultCard extends StatelessWidget {
  final VoltageDropResult resultado;

  const VdResultCard({
    super.key,
    required this.resultado,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            const Text(
              "Resultado",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              resultado.caidaTexto,
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              resultado.porcentajeTexto,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            LinearProgressIndicator(
              value: (resultado.caidaPorcentaje / 3).clamp(0.0, 1.0),
              minHeight: 10,
              borderRadius: BorderRadius.circular(10),
              backgroundColor: Colors.grey.shade300,
              valueColor: AlwaysStoppedAnimation<Color>(
                resultado.cumple
                    ? Colors.green
                    : Colors.red,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              resultado.cumple
                  ? "Dentro del límite recomendado (≤ 3 %)"
                  : "Supera el límite recomendado (> 3 %)",
              style: TextStyle(
                color: resultado.cumple
                    ? Colors.green
                    : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),

          ],
        ),
      ),
    );
  }
}