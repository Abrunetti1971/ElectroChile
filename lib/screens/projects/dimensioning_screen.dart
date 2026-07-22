import 'package:flutter/material.dart';

import '../../models/circuit.dart';
import '../../models/project.dart';
import '../../repositories/circuit_repository.dart';
import '../../services/calculators/conductor_calculator.dart';
import '../../services/circuit_service.dart';
import '../../widgets/calculation_result_card.dart';

class DimensioningScreen extends StatefulWidget {
  final Project project;
  final Circuit? circuit;

  const DimensioningScreen({
    super.key,
    required this.project,
    this.circuit,
  });

  @override
  State<DimensioningScreen> createState() => _DimensioningScreenState();
}

class _DimensioningScreenState extends State<DimensioningScreen> {
  final _name = TextEditingController();
  final _power = TextEditingController();
  final _length = TextEditingController();

  final CircuitService _circuitService = CircuitService(
    CircuitRepository(),
  );

  bool _threePhase = false;
  bool _copper = true;
  bool _saving = false;
  String _type = 'Alumbrado';

  ConductorSelectionResult? _result;

  static const _types = [
    'Alumbrado',
    'Enchufes',
    'Fuerza',
    'Motor',
    'Aire acondicionado',
    'Portón',
    'Bomba',
    'Otro',
  ];

  bool get _isEditing => widget.circuit != null;

  @override
  void initState() {
    super.initState();

    final circuit = widget.circuit;
    if (circuit == null) return;

    _name.text = circuit.name;
    _power.text = circuit.power.toString();
    _length.text = circuit.length.toString();
    _threePhase = circuit.phases == 3;
    _copper = circuit.conductorMaterial.toLowerCase() == 'cobre';
    _type = _types.contains(circuit.type) ? circuit.type : 'Otro';

    if (circuit.power > 0 && circuit.length > 0) {
      _result = ConductorCalculator.calculate(
        circuitType: circuit.type,
        voltage: _threePhase ? 380 : 220,
        power: circuit.power,
        length: circuit.length,
        copper: _copper,
        threePhase: _threePhase,
      );
    }
  }

  @override
  void dispose() {
    _name.dispose();
    _power.dispose();
    _length.dispose();
    super.dispose();
  }

  double _num(TextEditingController controller) {
    return double.tryParse(
          controller.text.trim().replaceAll(',', '.'),
        ) ??
        0;
  }

  void _calculate() {
    final power = _num(_power);
    final length = _num(_length);

    if (power <= 0 || length <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Ingrese una potencia y una longitud válidas.',
          ),
        ),
      );
      return;
    }

    setState(() {
      _result = ConductorCalculator.calculate(
        circuitType: _type,
        voltage: _threePhase ? 380 : 220,
        power: power,
        length: length,
        copper: _copper,
        threePhase: _threePhase,
      );
    });
  }

  int _protectionCurrent(
    double current,
    String circuitType,
  ) {
    final minimum = switch (circuitType.trim().toLowerCase()) {
      'alumbrado' => 10,
      'enchufes' => 16,
      'fuerza' => 16,
      'motor' => 16,
      'aire acondicionado' => 16,
      'portón' => 16,
      'porton' => 16,
      'bomba' => 16,
      _ => 16,
    };
    const ratings = <int>[6,10,16,20,25,32,40,50,63,80,100,125,160,200,250];
    final designCurrent = current * 1.25;
    for (final rating in ratings) {
      if (rating >= designCurrent && rating >= minimum) return rating;
    }
    return ratings.last;
  }

  String _conduitForSection(double section) {
    if (section <= 2.5) return 'PVC 20 mm';
    if (section <= 6) return 'PVC 25 mm';
    if (section <= 16) return 'PVC 32 mm';
    if (section <= 35) return 'PVC 40 mm';
    return 'Canalización por dimensionar';
  }

  Future<int> _nextCircuitNumber() async {
    final existingCircuits = await _circuitService.getCircuits(
      widget.project.id,
    );

    if (existingCircuits.isEmpty) return 1;

    return existingCircuits
            .map((circuit) => circuit.number)
            .reduce((a, b) => a > b ? a : b) +
        1;
  }

  Future<void> _saveCircuit() async {
    final result = _result;
    final name = _name.text.trim();

    if (result == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Primero debe calcular el circuito.'),
        ),
      );
      return;
    }

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ingrese el nombre del circuito.'),
        ),
      );
      return;
    }

    if (_saving) return;

    setState(() {
      _saving = true;
    });

    try {
      final existing = widget.circuit;
      final now = DateTime.now();
      final protectionCurrent = _protectionCurrent(result.current, _type);

      final circuit = Circuit(
        id: existing?.id ?? now.microsecondsSinceEpoch.toString(),
        projectId: widget.project.id,
        number: existing?.number ?? await _nextCircuitNumber(),
        name: name,
        type: _type,
        voltage: _threePhase ? 380 : 220,
        phases: _threePhase ? 3 : 1,
        power: _num(_power),
        current: result.current,
        powerFactor: existing?.powerFactor ?? 1.0,
        demandFactor: existing?.demandFactor ?? 1.0,
        length: _num(_length),
        conductorMaterial: _copper ? 'Cobre' : 'Aluminio',
        conductorSection: result.section,
        conduit: _conduitForSection(result.section),
        protection: '$protectionCurrent A curva C',
        differential: '$protectionCurrent A / 30 mA',
        earth: '${result.section.toStringAsFixed(1)} mm²',
        status: result.complies ? 'OK' : 'REVISAR',
        notes:
            'Caída de tensión: ${result.voltageDropPercent.toStringAsFixed(2)} %',
        createdAt: existing?.createdAt ?? now,
        updatedAt: now,
      );

      if (_isEditing) {
        await _circuitService.updateCircuit(circuit);
      } else {
        await _circuitService.addCircuit(circuit);
      }

      if (!mounted) return;
      Navigator.pop(context, true);
    } catch (error) {
      if (!mounted) return;

      setState(() {
        _saving = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isEditing
                ? 'No fue posible actualizar el circuito: $error'
                : 'No fue posible guardar el circuito: $error',
          ),
        ),
      );
    }
  }

  void _invalidateResult() {
    if (_result == null) return;

    setState(() {
      _result = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isEditing
              ? 'Editar circuito - ${widget.project.name}'
              : 'Dimensionamiento - ${widget.project.name}',
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: _name,
            textCapitalization: TextCapitalization.sentences,
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
                  (type) => DropdownMenuItem(
                    value: type,
                    child: Text(type),
                  ),
                )
                .toList(),
            onChanged: (value) {
              if (value == null) return;

              setState(() {
                _type = value;
                _result = null;
              });
            },
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
            onSelectionChanged: (selection) {
              setState(() {
                _threePhase = selection.first;
                _result = null;
              });
            },
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _power,
            keyboardType: const TextInputType.numberWithOptions(
              decimal: true,
            ),
            onChanged: (_) => _invalidateResult(),
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
            onChanged: (_) => _invalidateResult(),
            decoration: const InputDecoration(
              labelText: 'Longitud (m)',
              border: OutlineInputBorder(),
            ),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            value: _copper,
            title: Text(
              _copper
                  ? 'Conductor de cobre'
                  : 'Conductor de aluminio',
            ),
            onChanged: (value) {
              setState(() {
                _copper = value;
                _result = null;
              });
            },
          ),
          FilledButton.icon(
            onPressed: _saving ? null : _calculate,
            icon: const Icon(Icons.calculate),
            label: const Text('CALCULAR'),
          ),
          if (_result != null) ...[
            const SizedBox(height: 20),
            CalculationResultCard(
              ib: _result!.current,
              iz: 24,
              breaker: _protectionCurrent(_result!.current, _type),
              section: _result!.section,
              voltageDrop: _result!.voltageDropPercent,
              complies: _result!.complies,

              differential:
              "${_protectionCurrent(_result!.current, _type)} A / 30 mA",

              conduit:
              _conduitForSection(_result!.section),

              earth:
              "${_result!.section.toStringAsFixed(1)} mm²",

              observations: _result!.complies
                  ? "El circuito cumple con los criterios de diseño utilizados en ElectroChile PRO."
                  : "Revisar la caída de tensión, la protección seleccionada o la sección del conductor.",
            ),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _saving ? null : _saveCircuit,
              icon: _saving
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    )
                  : Icon(_isEditing ? Icons.update : Icons.save),
              label: Text(
                _saving
                    ? (_isEditing ? 'ACTUALIZANDO...' : 'GUARDANDO...')
                    : (_isEditing
                        ? 'ACTUALIZAR CIRCUITO'
                        : 'GUARDAR EN EL PROYECTO'),
              ),
            ),
          ],
        ],
      ),
    );
  }
}