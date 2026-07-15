import 'package:flutter/material.dart';

import '../../models/circuit.dart';
import '../../services/electrical_calculator_service.dart';

class CircuitDetailScreen extends StatelessWidget {
final Circuit circuit;
final Future<void> Function()? onEdit;
final Future<void> Function()? onDelete;

const CircuitDetailScreen({
super.key,
required this.circuit,
this.onEdit,
this.onDelete,
});

static const ElectricalCalculatorService _calc =
ElectricalCalculatorService();

Widget _row({
required IconData icon,
required String title,
required String value,
}) {
return Padding(
padding: const EdgeInsets.symmetric(
vertical: 8,
),
child: Row(
children: [
Icon(
icon,
color: Colors.blue,
),
const SizedBox(width: 12),
Expanded(
child: Text(
title,
style: const TextStyle(
fontWeight: FontWeight.bold,
),
),
),
Text(value),
],
),
);
}

@override
Widget build(BuildContext context) {

final section =
_calc.recommendedSectionForCircuit(
circuitType: circuit.type,
current: circuit.current,
length: circuit.length,
voltage: circuit.voltage,
);

final breaker =
_calc.recommendedBreaker(
circuit.current,
circuitType: circuit.type,
);

final differential =
_calc.recommendedDifferential(
breaker.toDouble(),
);

final drop =
_calc.voltageDrop(
current: circuit.current,
length: circuit.length,
section: section,
voltage: circuit.voltage,
);

final ok =
_calc.compliesVoltageDrop(
drop,
);

return Scaffold(
appBar: AppBar(
title: Text(circuit.name),
),
body: ListView(
padding: const EdgeInsets.all(18),
children: [

Card(
child: Padding(
padding: const EdgeInsets.all(18),
child: Column(
children: [

_row(
icon: Icons.category,
title: "Tipo",
value: circuit.type,
),

_row(
icon: Icons.bolt,
title: "Voltaje",
value:
"${circuit.voltage.toStringAsFixed(0)} V",
),

_row(
icon: Icons.flash_on,
title: "Potencia",
value:
"${circuit.power.toStringAsFixed(0)} W",
),

_row(
icon: Icons.speed,
title: "Corriente",
value:
"${circuit.current.toStringAsFixed(2)} A",
),

_row(
icon: Icons.straighten,
title: "Longitud",
value:
"${circuit.length.toStringAsFixed(1)} m",
),
  const Divider(height: 30),

  const Text(
    "Cálculo Automático",
    style: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),

  const SizedBox(height: 18),

  _row(
    icon: Icons.cable,
    title: "Conductor recomendado",
    value:
    "${section.toStringAsFixed(1)} mm²",
  ),

  _row(
    icon: Icons.electrical_services,
    title: "Disyuntor recomendado",
    value: "$breaker A",
  ),

  _row(
    icon: Icons.health_and_safety,
    title: "Diferencial recomendado",
    value: differential,
  ),

  _row(
    icon: Icons.show_chart,
    title: "Caída de tensión",
    value:
    "${drop.toStringAsFixed(2)} %",
  ),
],
),
),
),

  const SizedBox(height: 16),

  Card(
    color: ok
        ? Colors.green.shade50
        : Colors.orange.shade50,
    child: ListTile(
      leading: Icon(
        ok
            ? Icons.check_circle
            : Icons.warning,
        color: ok
            ? Colors.green
            : Colors.orange,
        size: 38,
      ),
      title: Text(
        ok
            ? "Cumple SEC"
            : "No cumple SEC",
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        ok
            ? "La caída de tensión está dentro del límite permitido."
            : "La caída de tensión supera el límite recomendado.",
      ),
    ),
  ),

  const SizedBox(height: 24),

  if (onEdit != null)
    FilledButton.icon(
      onPressed: () async {
        await onEdit!();

        if (context.mounted) {
          Navigator.pop(
            context,
            true,
          );
        }
      },
      icon: const Icon(Icons.edit),
      label: const Text(
        "Editar circuito",
      ),
    ),

  const SizedBox(height: 12),

  if (onDelete != null)
    OutlinedButton.icon(
      onPressed: () async {
        final eliminar =
        await showDialog<bool>(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text(
              "Eliminar circuito",
            ),
            content: Text(
              "¿Eliminar '${circuit.name}'?",
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                    false,
                  );
                },
                child: const Text(
                  "Cancelar",
                ),
              ),
              FilledButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                    true,
                  );
                },
                child: const Text(
                  "Eliminar",
                ),
              ),
            ],
          ),
        );

        if (eliminar != true) {
          return;
        }

        await onDelete!();

        if (context.mounted) {
          Navigator.pop(
            context,
            true,
          );
        }
      },
      icon: const Icon(
        Icons.delete,
        color: Colors.red,
      ),
      label: const Text(
        "Eliminar circuito",
        style: TextStyle(
          color: Colors.red,
        ),
      ),
    ),

  const SizedBox(height: 30),
],
),
);
}
}