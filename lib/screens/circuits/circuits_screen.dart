import 'package:flutter/material.dart';

import '../../models/circuit.dart';
import '../../models/project.dart';
import '../../repositories/circuit_repository.dart';
import '../../services/circuit_service.dart';
import 'circuit_detail_screen.dart';
import 'circuit_form_dialog.dart';

class CircuitsScreen extends StatefulWidget {
  final Project project;

  const CircuitsScreen({
    super.key,
    required this.project,
  });

  @override
  State<CircuitsScreen> createState() =>
      _CircuitsScreenState();
}

class _CircuitsScreenState
    extends State<CircuitsScreen> {
final CircuitService _service =
CircuitService(
CircuitRepository(),
);

List<Circuit> _circuits = [];

bool _loading = true;

@override
void initState() {
super.initState();
_loadCircuits();
}

Future<void> _loadCircuits() async {
setState(() {
_loading = true;
});

final data =
await _service.getCircuits(
widget.project.id,
);

if (!mounted) return;

setState(() {
_circuits = data;
_loading = false;
});
}

Future<void> _newCircuit() async {
final result =
await showModalBottomSheet<
Map<String, dynamic>>(
context: context,
isScrollControlled: true,
useSafeArea: true,
builder: (_) =>
const CircuitFormDialog(),
);

if (result == null) return;

final power =
double.tryParse(
result["power"] ?? "",
) ??
0;

final voltage = 220.0;

final current =
_service.calculateCurrent(
power: power,
voltage: voltage,
);

final now = DateTime.now();

final circuit = Circuit(
id: now.microsecondsSinceEpoch
.toString(),
projectId: widget.project.id,
name: result["name"]!,
type: result["type"]!,
voltage: voltage,
power: power,
current: current,
length:
double.tryParse(
result["length"] ??
"",
) ??
0,
conductorMaterial: "Cobre",
conductorSection: 1.5,
protection: "10 A",
notes: "",
createdAt: now,
updatedAt: now,
);

await _service.addCircuit(
circuit,
);

await _loadCircuits();
}

Future<void> _openCircuit(
Circuit circuit,
) async {
final refresh =
await Navigator.push<bool>(
context,
MaterialPageRoute(
builder: (_) =>
CircuitDetailScreen(
circuit: circuit,
onEdit: () async {},
onDelete: () async {
await _service.deleteCircuit(
circuit.id,
);
},
),
),
);

if (refresh == true) {
await _loadCircuits();
}
}
Future<void> _deleteCircuit(
    Circuit circuit,
    ) async {
  final confirmed =
  await showDialog<bool>(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        title: const Text(
          'Eliminar circuito',
        ),
        content: Text(
          '¿Eliminar "${circuit.name}"?',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(
                dialogContext,
                false,
              );
            },
            child: const Text(
              'Cancelar',
            ),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(
                dialogContext,
                true,
              );
            },
            child: const Text(
              'Eliminar',
            ),
          ),
        ],
      );
    },
  );

  if (confirmed != true) return;

  await _service.deleteCircuit(
    circuit.id,
  );

  await _loadCircuits();
}

@override
Widget build(
    BuildContext context,
    ) {
  return Scaffold(
    appBar: AppBar(
      title: Text(
        'Circuitos - ${widget.project.name}',
      ),
    ),
    floatingActionButton:
    FloatingActionButton.extended(
      onPressed: _newCircuit,
      icon: const Icon(Icons.add),
      label: const Text('Nuevo'),
    ),
    body: _loading
        ? const Center(
      child:
      CircularProgressIndicator(),
    )
        : _circuits.isEmpty
        ? const Center(
      child: Text(
        'No existen circuitos.\n\nPresione NUEVO.',
        textAlign:
        TextAlign.center,
      ),
    )
        : RefreshIndicator(
      onRefresh:
      _loadCircuits,
      child:
      ListView.builder(
        padding:
        const EdgeInsets.all(
            16),
        itemCount:
        _circuits.length,
        itemBuilder:
            (_, index) {
          final circuit =
          _circuits[index];

          return Card(
            margin:
            const EdgeInsets.only(
              bottom: 12,
            ),
            child:
            ListTile(
              leading:
              const CircleAvatar(
                child: Icon(
                  Icons
                      .electrical_services,
                ),
              ),
              title: Text(
                circuit.name,
              ),
              subtitle:
              Text(
                '${circuit.type}\n'
                    '${circuit.power.toStringAsFixed(0)} W   '
                    '${circuit.current.toStringAsFixed(2)} A',
              ),
              isThreeLine:
              true,
              onTap: () =>
                  _openCircuit(
                    circuit,
                  ),
              trailing:
              IconButton(
                icon:
                const Icon(
                  Icons.delete,
                  color:
                  Colors.red,
                ),
                onPressed:
                    () =>
                    _deleteCircuit(
                      circuit,
                    ),
              ),
            ),
          );
        },
      ),
    ),
  );
}
}