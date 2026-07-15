import 'package:flutter/material.dart';

import '../../models/circuit.dart';
import '../../repositories/circuit_repository.dart';
import '../../services/circuit_service.dart';
import '../../widgets/circuit_form_dialog.dart';

class CircuitsScreen extends StatefulWidget {
  final String projectId;
  final String projectName;

  const CircuitsScreen({
    super.key,
    required this.projectId,
    required this.projectName,
  });

  @override
  State<CircuitsScreen> createState() => _CircuitsScreenState();
}

class _CircuitsScreenState extends State<CircuitsScreen> {
  late final CircuitRepository _repository;
  late final CircuitService _service;

  @override
  void initState() {
    super.initState();

    _repository = CircuitRepository();
    _service = CircuitService(_repository);
  }

  Future<void> _newCircuit() async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      builder: (_) => const CircuitFormDialog(),
    );

    if (result == null) return;

    final id = DateTime.now().millisecondsSinceEpoch.toString();

    _service.createCircuit(
      id: id,
      projectId: widget.projectId,
      name: result["name"],
      type: result["type"],
      voltage: result["voltage"],
      power: result["power"],
      length: result["length"],
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final circuits = _service.getCircuits(widget.projectId);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.projectName),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _newCircuit,
        icon: const Icon(Icons.add),
        label: const Text("Nuevo"),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            color: Colors.blue.shade50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.projectName,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Circuitos registrados: ${circuits.length}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: circuits.isEmpty
                ? const Center(
              child: Text(
                "Este proyecto aún no tiene circuitos.\n\nPresione NUEVO para comenzar.",
                textAlign: TextAlign.center,
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: circuits.length,
              itemBuilder: (_, index) {
                final Circuit circuit = circuits[index];

                return Card(
                  elevation: 3,
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(
                        "${index + 1}",
                      ),
                    ),
                    title: Text(
                      circuit.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text(circuit.typeName),
                        Text(
                            "${circuit.power.toStringAsFixed(0)} W"),
                        Text(
                            "${circuit.current.toStringAsFixed(2)} A"),
                      ],
                    ),
                    trailing: const Icon(
                      Icons.chevron_right,
                    ),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Circuito: ${circuit.name}",
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}