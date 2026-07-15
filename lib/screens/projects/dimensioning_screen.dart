import 'package:flutter/material.dart';

import '../../models/project.dart';
import '../../services/calculators/conductor_calculator.dart';

class DimensioningScreen extends StatefulWidget {
  final Project project;

  const DimensioningScreen({
    super.key,
    required this.project,
  });

  @override
  State<DimensioningScreen> createState() => _DimensioningScreenState();
}

class _DimensioningScreenState extends State<DimensioningScreen> {
  final _name = TextEditingController();
  final _power = TextEditingController();
  final _length = TextEditingController();

  bool _threePhase = false;
  bool _copper = true;
  String _type = 'Alumbrado';

  ConductorSelectionResult? _result;

  final _types = const [
    'Alumbrado',
    'Enchufes',
    'Fuerza',
    'Motor',
    'Aire acondicionado',
    'Otro',
  ];

  @override
  void dispose() {
    _name.dispose();
    _power.dispose();
    _length.dispose();
    super.dispose();
  }

  double _num(TextEditingController c) =>
      double.tryParse(c.text.replaceAll(',', '.')) ?? 0;

  void _calculate() {
    setState(() {
      _result = ConductorCalculator.calculate(
        voltage: _threePhase ? 380 : 220,
        power: _num(_power),
        length: _num(_length),
        copper: _copper,
        threePhase: _threePhase,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dimensionamiento - ${widget.project.name}',
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: _name,
            decoration: const InputDecoration(
              labelText: 'Nombre del circuito',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),

          DropdownButtonFormField<String>(
            initialValue: _type,
            decoration: const InputDecoration(
              labelText: 'Tipo',
              border: OutlineInputBorder(),
            ),
            items: _types
                .map(
                  (e) => DropdownMenuItem(
                value: e,
                child: Text(e),
              ),
            )
                .toList(),
            onChanged: (v) => setState(() => _type = v!),
          ),

          const SizedBox(height: 12),

          SegmentedButton<bool>(
            segments: const [
              ButtonSegment(
                value: false,
                label: Text('220 V'),
              ),
              ButtonSegment(
                value: true,
                label: Text('380 V'),
              ),
            ],
            selected: {_threePhase},
            onSelectionChanged: (v) {
              setState(() {
                _threePhase = v.first;
              });
            },
          ),

          const SizedBox(height: 12),

          TextField(
            controller: _power,
            keyboardType: const TextInputType.numberWithOptions(
              decimal: true,
            ),
            decoration: const InputDecoration(
              labelText: 'Potencia (W)',
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 12),

          TextField(
            controller: _length,
            keyboardType: const TextInputType.numberWithOptions(
              decimal: true,
            ),
            decoration: const InputDecoration(
              labelText: 'Longitud (m)',
              border: OutlineInputBorder(),
            ),
          ),

          SwitchListTile(
            value: _copper,
            title: const Text('Conductor de cobre'),
            onChanged: (v) {
              setState(() {
                _copper = v;
              });
            },
          ),

          FilledButton.icon(
            onPressed: _calculate,
            icon: const Icon(Icons.calculate),
            label: const Text('CALCULAR'),
          ),

          if (_result != null) ...[
            const SizedBox(height: 20),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _row(
                      'Corriente',
                      '${_result!.current.toStringAsFixed(2)} A',
                    ),
                    _row(
                      'Conductor',
                      '${_result!.section.toStringAsFixed(_result!.section.truncateToDouble() == _result!.section ? 0 : 1)} mm²',
                    ),
                    _row(
                      'Caída',
                      '${_result!.voltageDropPercent.toStringAsFixed(2)} %',
                    ),
                    const Divider(),
                    Text(
                      _result!.complies
                          ? '🟢 CUMPLE'
                          : '🔴 NO CUMPLE',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: _result!.complies
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            FilledButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Conexión al módulo Circuitos preparada.',
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.save),
              label: const Text('GUARDAR EN EL PROYECTO'),
            ),
          ],
        ],
      ),
    );
  }

  Widget _row(String a, String b) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              a,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(b),
        ],
      ),
    );
  }
}