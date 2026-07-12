import 'package:flutter/material.dart';

import '../conductors_result.dart';

class ConductorsSecCard extends StatelessWidget {
  final ConductorsResult resultado;

  const ConductorsSecCard({
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Center(
              child: Text(
                "FICHA TÉCNICA SEC",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 20),

            _fila(
              Icons.cable,
              "Material",
              resultado.material,
            ),

            _fila(
              Icons.electrical_services,
              "Sistema",
              resultado.sistema,
            ),

            _fila(
              Icons.route,
              "Método instalación",
              resultado.metodoInstalacion,
            ),

            _fila(
              Icons.shield,
              "Aislación",
              resultado.aislacion,
            ),

            _fila(
              Icons.thermostat,
              "Temperatura",
              resultado.temperaturaTexto,
            ),

            _fila(
              Icons.account_tree,
              "Agrupamiento",
              "${resultado.circuitosAgrupados} circuito(s)",
            ),

            const Divider(height: 30),

            _fila(
              Icons.bolt,
              "Voltaje",
              resultado.voltajeTexto,
            ),

            _fila(
              Icons.flash_on,
              "Corriente",
              resultado.corrienteTexto,
            ),

            _fila(
              Icons.straighten,
              "Longitud",
              resultado.longitudTexto,
            ),

            const Divider(height: 30),

            _fila(
              Icons.cable,
              "Conductor Final",
              resultado.conductorFinalTexto,
            ),

            _fila(
              Icons.security,
              "Protección",
              resultado.proteccionTexto,
            ),

            _fila(
              Icons.health_and_safety,
              "Diferencial",
              resultado.diferencial,
            ),

            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: resultado.cumple
                    ? Colors.green.shade50
                    : Colors.red.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [

                  Icon(
                    resultado.cumple
                        ? Icons.verified
                        : Icons.warning,
                    color: resultado.cumple
                        ? Colors.green
                        : Colors.red,
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Text(
                      resultado.estadoTexto,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: resultado.cumple
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
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
      IconData icono,
      String titulo,
      String valor,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 6,
      ),
      child: Row(
        children: [

          Icon(
            icono,
            size: 20,
            color: Colors.blue,
          ),

          const SizedBox(width: 10),

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