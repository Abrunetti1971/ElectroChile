import 'package:flutter/material.dart';

class CalculationResultCard extends StatelessWidget {
  final double ib;
  final double iz;
  final int breaker;
  final double section;
  final double voltageDrop;
  final bool complies;

  // Nuevos campos (opcionales)
  final String differential;
  final String conduit;
  final String earth;
  final String observations;

  const CalculationResultCard({
    super.key,
    required this.ib,
    required this.iz,
    required this.breaker,
    required this.section,
    required this.voltageDrop,
    required this.complies,
    this.differential = '-',
    this.conduit = '-',
    this.earth = '-',
    this.observations = 'Sin observaciones.',
  });

  Widget _item(
      IconData icon,
      String title,
      String value,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 20,
            color: Colors.blue,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(value),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final statusColor =
    complies ? Colors.green : Colors.red;

    final statusText =
    complies ? '✔ CUMPLE RIC' : '✘ NO CUMPLE RIC';

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [

            const Text(
              'RESULTADO DEL CÁLCULO',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            _item(
              Icons.bolt,
              'Corriente (Ib)',
              '${ib.toStringAsFixed(2)} A',
            ),

            _item(
              Icons.cable,
              'Conductor',
              '${section.toStringAsFixed(1)} mm²',
            ),

            _item(
              Icons.electrical_services,
              'Ampacidad (Iz)',
              '${iz.toStringAsFixed(2)} A',
            ),

            _item(
              Icons.shield,
              'Protección',
              '$breaker A Curva C',
            ),

            _item(
              Icons.health_and_safety,
              'Diferencial',
              differential,
            ),

            _item(
              Icons.route,
              'Canalización',
              conduit,
            ),

            _item(
              Icons.public,
              'Tierra de protección',
              earth,
            ),

            _item(
              Icons.trending_down,
              'Caída de tensión',
              '${voltageDrop.toStringAsFixed(2)} %',
            ),

            const Divider(height: 30),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: statusColor,
                borderRadius:
                BorderRadius.circular(10),
              ),
              child: Text(
                statusText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'OBSERVACIONES',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 6),

            Text(observations),
          ],
        ),
      ),
    );
  }
}