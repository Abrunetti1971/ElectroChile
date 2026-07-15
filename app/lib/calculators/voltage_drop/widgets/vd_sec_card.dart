import 'package:flutter/material.dart';

import '../voltage_drop_result.dart';

class VdSecCard extends StatelessWidget {

final VoltageDropResult resultado;

const VdSecCard({

super.key,

required this.resultado,

});

@override
Widget build(BuildContext context) {

final bool cumple = resultado.cumple;

return Card(

elevation: 8,

shape: RoundedRectangleBorder(

borderRadius: BorderRadius.circular(20),

),

child: Padding(

padding: const EdgeInsets.all(22),

child: Column(

crossAxisAlignment:
CrossAxisAlignment.start,

children: [

Row(

children: [

Icon(

Icons.verified,

color: Colors.green.shade700,

size: 30,

),

const SizedBox(width:12),

const Expanded(

child: Text(

"RECOMENDACIÓN TÉCNICA",

style: TextStyle(

fontSize:22,

fontWeight: FontWeight.bold,

),

),

),

],

),

const SizedBox(height:20),

Divider(),

const SizedBox(height:15),

const Text(

"DATOS DEL CIRCUITO",

style: TextStyle(

fontWeight: FontWeight.bold,

fontSize:18,

),

),

const SizedBox(height:15),
  _fila(
    Icons.power,
    "Sistema",
    resultado.sistema,
  ),

  const SizedBox(height: 10),

  _fila(
    Icons.cable,
    "Material",
    resultado.material,
  ),

  const SizedBox(height: 10),

  _fila(
    Icons.bolt,
    "Voltaje",
    "${resultado.voltaje.toStringAsFixed(0)} V",
  ),

  const SizedBox(height: 10),

  _fila(
    Icons.electric_meter,
    "Corriente",
    "${resultado.corriente.toStringAsFixed(0)} A",
  ),

  const SizedBox(height: 10),

  _fila(
    Icons.straighten,
    "Longitud",
    "${resultado.longitud.toStringAsFixed(0)} m",
  ),

  const SizedBox(height: 22),

  Divider(),

  const SizedBox(height: 15),

  const Center(
    child: Text(
      "CONDUCTORES",
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),

  const SizedBox(height: 20),

  _fila(
    Icons.check_circle_outline,
    "Ampacidad",
    resultado.conductorAmpacidadTexto,
  ),

  const SizedBox(height: 10),

  Center(
    child: Icon(
      Icons.arrow_downward,
      size: 32,
      color: Colors.grey.shade600,
    ),
  ),

  const SizedBox(height: 10),

  Center(
    child: Text(
      resultado.conductorTexto,
      style: TextStyle(
        fontSize: 38,
        fontWeight: FontWeight.bold,
        color: Colors.blue.shade700,
      ),
    ),
  ),

  const SizedBox(height: 25),

  Divider(),

  const SizedBox(height: 15),

  const Center(
    child: Text(
      "CAÍDA DE TENSIÓN",
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),

  const SizedBox(height: 18),

  Center(
    child: Text(
      resultado.caidaTexto,
      style: const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),

  const SizedBox(height: 8),

  Center(
    child: Text(
      resultado.porcentajeTexto,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),

  const SizedBox(height: 22),

  Divider(),

  const SizedBox(height: 15),

  const Text(
    "PROTECCIONES",
    style: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
  ),

  const SizedBox(height: 15),

  _fila(
    Icons.electrical_services,
    "Automático",
    resultado.proteccionTexto,
  ),

  const SizedBox(height: 10),

  _fila(
    Icons.health_and_safety,
    "Diferencial",
    resultado.diferencial,
  ),

  const SizedBox(height: 22),

  Divider(),

  const SizedBox(height: 15),

  const Text(
    "OBSERVACIÓN",
    style: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
  ),

  const SizedBox(height: 12),

  Container(
    width: double.infinity,
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.orange.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: Colors.orange.shade300,
      ),
    ),
    child: Text(
      resultado.observacion,
      style: const TextStyle(
        fontSize: 14,
        height: 1.45,
      ),
    ),
  ),

  const SizedBox(height: 22),

  Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(
      vertical: 16,
    ),
    decoration: BoxDecoration(
      color: cumple
          ? Colors.green.shade50
          : Colors.red.shade50,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(
        color: cumple
            ? Colors.green
            : Colors.red,
      ),
    ),
    child: Row(
      mainAxisAlignment:
      MainAxisAlignment.center,
      children: [

        Icon(
          cumple
              ? Icons.check_circle
              : Icons.cancel,
          color: cumple
              ? Colors.green
              : Colors.red,
        ),

        const SizedBox(width: 10),

        Text(
          cumple
              ? "CUMPLE CRITERIO SEC"
              : "NO CUMPLE CRITERIO SEC",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: cumple
                ? Colors.green.shade700
                : Colors.red.shade700,
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
  return Row(
    children: [

      Icon(
        icono,
        size: 22,
        color: Colors.grey.shade700,
      ),

      const SizedBox(width: 12),

      Expanded(
        child: Text(
          titulo,
          style: const TextStyle(
            fontSize: 15,
          ),
        ),
      ),

      Text(
        valor,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),

    ],
  );
}
}