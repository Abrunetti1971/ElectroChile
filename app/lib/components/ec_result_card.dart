import 'package:flutter/material.dart';

class EcResultCard extends StatelessWidget {

  final String titulo;
  final String resultado;
  final String unidad;
  final String formula;
  final String descripcion;

  const EcResultCard({
    super.key,
    required this.titulo,
    required this.resultado,
    required this.unidad,
    required this.formula,
    required this.descripcion,
  });

  @override
  Widget build(BuildContext context) {

    return Card(

      elevation: 4,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),

      child: Padding(

        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            Text(
              titulo,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Text(
              "$resultado $unidad",
              style: const TextStyle(
                fontSize: 34,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Text(formula),

            const SizedBox(height: 20),

            Text(
              descripcion,
              textAlign: TextAlign.center,
            ),

          ],

        ),

      ),

    );

  }

}