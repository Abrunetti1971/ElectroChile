import 'package:flutter/material.dart';

import '../conductors_result.dart';

class ConductorsResultCard extends StatelessWidget {
  final ConductorsResult resultado;

  const ConductorsResultCard({
    super.key,
    required this.resultado,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            const Text(
              "CONDUCTOR RECOMENDADO",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Text(
              resultado.conductorFinalTexto,
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),

            const SizedBox(height: 25),

            const Divider(),

            _fila(
              "Por ampacidad",
              resultado.conductorAmpacidadTexto,
            ),

            _fila(
              "Por caída de tensión",
              resultado.conductorCaidaTexto,
            ),

            _fila(
              "Protección",
              resultado.proteccionTexto,
            ),

            _fila(
              "Diferencial",
              resultado.diferencial,
            ),

            _fila(
              "Factor temperatura",
              resultado.factorTemperaturaTexto,
            ),

            _fila(
              "Factor agrupamiento",
              resultado.factorAgrupamientoTexto,
            ),

            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: resultado.cumple
                    ? Colors.green.shade50
                    : Colors.red.shade50,
                borderRadius:
                BorderRadius.circular(12),
              ),
              child: Column(
                children: [

                  Icon(
                    resultado.cumple
                        ? Icons.check_circle
                        : Icons.error,
                    size: 40,
                    color: resultado.cumple
                        ? Colors.green
                        : Colors.red,
                  ),

                  const SizedBox(height: 10),

                  Text(
                    resultado.estadoTexto,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: resultado.cumple
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    resultado.observacion,
                    textAlign: TextAlign.center,
                  ),

                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget _fila(
      String titulo,
      String valor,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 6,
      ),
      child: Row(
        children: [

          Expanded(
            child: Text(
              titulo,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          Text(
            valor,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),

        ],
      ),
    );
  }
}