import 'package:flutter/material.dart';

import '../../models/circuit.dart';
import '../../models/project.dart';
import '../../repositories/circuit_repository.dart';
import '../../services/circuit_service.dart';
import '../projects/dimensioning_screen.dart';
import 'circuit_detail_screen.dart';

class CircuitsScreen extends StatefulWidget {
  final Project project;

  const CircuitsScreen({
    super.key,
    required this.project,
  });

  @override
  State<CircuitsScreen> createState() => _CircuitsScreenState();
}

class _CircuitsScreenState extends State<CircuitsScreen> {
  final CircuitService _service = CircuitService(
    CircuitRepository(),
  );

  List<Circuit> _circuits = [];
  bool _loading = true;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _loadCircuits();
  }

  Future<void> _loadCircuits() async {
    if (mounted) {
      setState(() {
        _loading = true;
      });
    }

    final data = await _service.getCircuits(
      widget.project.id,
    );

    if (!mounted) return;

    setState(() {
      _circuits = data;
      _loading = false;
    });
  }

  Future<void> _newCircuit() async {
    if (_saving) return;

    setState(() {
      _saving = true;
    });

    try {
      final saved = await Navigator.push<bool>(
        context,
        MaterialPageRoute(
          builder: (_) => DimensioningScreen(
            project: widget.project,
          ),
        ),
      );

      if (saved == true) {
        await _loadCircuits();
      }
    } finally {
      if (mounted) {
        setState(() {
          _saving = false;
        });
      }
    }
  }

  Future<void> _openCircuit(Circuit circuit) async {
    final refresh = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => CircuitDetailScreen(
          project: widget.project,
          circuit: circuit,
          onEdit: () async {
            final updated = await Navigator.push<bool>(
              context,
              MaterialPageRoute(
                builder: (_) => DimensioningScreen(
                  project: widget.project,
                  circuit: circuit,
                ),
              ),
            );

            if (updated == true) {
              await _loadCircuits();
            }
          },
          onDelete: () async {
            await _service.deleteCircuit(circuit.id);
          },
        ),
      ),
    );

    if (refresh == true) {
      await _loadCircuits();
    }
  }

  Future<void> _deleteCircuit(Circuit circuit) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Eliminar circuito'),
          content: Text('¿Eliminar "${circuit.name}"?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );

    if (confirmed != true) return;

    await _service.deleteCircuit(circuit.id);
    await _loadCircuits();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Circuitos - ${widget.project.name}'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _saving ? null : _newCircuit,
        icon: _saving
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : const Icon(Icons.add),
        label: Text(_saving ? 'Guardando...' : 'Nuevo'),
      ),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _circuits.isEmpty
              ? const Center(
                  child: Text(
                    'No existen circuitos.\n\nPresione NUEVO.',
                    textAlign: TextAlign.center,
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _loadCircuits,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _circuits.length,
                    itemBuilder: (_, index) {
                      final circuit = _circuits[index];

                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text('${circuit.number}'),
                          ),
                          title: Text(circuit.name),
                          subtitle: Text(
                            '${circuit.type}\n'
                            '${circuit.power.toStringAsFixed(0)} W   '
                            '${circuit.current.toStringAsFixed(2)} A',
                          ),
                          isThreeLine: true,
                          onTap: () => _openCircuit(circuit),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () => _deleteCircuit(circuit),
                          ),
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}
