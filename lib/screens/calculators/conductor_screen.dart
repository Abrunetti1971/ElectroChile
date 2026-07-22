import 'package:flutter/material.dart';

import '../../services/calculators/conductor_calculator.dart';

class ConductorScreen extends StatefulWidget {
  const ConductorScreen({super.key});

  @override
  State<ConductorScreen> createState() => _ConductorScreenState();
}

class _ConductorScreenState extends State<ConductorScreen> {
  final _powerController = TextEditingController();
  final _lengthController = TextEditingController();

  bool _threePhase = false;
  bool _copper = true;

  ConductorSelectionResult? _result;
  String? _errorMessage;

  @override
  void dispose() {
    _powerController.dispose();
    _lengthController.dispose();
    super.dispose();
  }

  double? _parseValue(String value) {
    final normalized = value.replaceAll(',', '.').trim();

    if (normalized.isEmpty) {
      return null;
    }

    return double.tryParse(normalized);
  }

  void _calculate() {
    final power = _parseValue(_powerController.text);
    final length = _parseValue(_lengthController.text);

    if (power == null || power <= 0) {
      setState(() {
        _result = null;
        _errorMessage = 'Ingrese una potencia válida.';
      });
      return;
    }

    if (length == null || length <= 0) {
      setState(() {
        _result = null;
        _errorMessage = 'Ingrese una longitud válida.';
      });
      return;
    }

    final result = ConductorCalculator.calculate(
      circuitType: 'Otro',
      voltage: _threePhase ? 380 : 220,
      power: power,
      length: length,
      copper: _copper,
      threePhase: _threePhase,
    );

    setState(() {
      _result = result;
      _errorMessage = null;
    });
  }

  void _clear() {
    _powerController.clear();
    _lengthController.clear();

    setState(() {
      _threePhase = false;
      _copper = true;
      _result = null;
      _errorMessage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selección de Conductor'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Sistema',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          SegmentedButton<bool>(
            segments: const [
              ButtonSegment<bool>(
                value: false,
                icon: Icon(Icons.home),
                label: Text('220 V'),
              ),
              ButtonSegment<bool>(
                value: true,
                icon: Icon(Icons.factory),
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
          const SizedBox(height: 18),
          TextField(
            controller: _powerController,
            keyboardType: const TextInputType.numberWithOptions(
              decimal: true,
            ),
            decoration: const InputDecoration(
              labelText: 'Potencia (W)',
              prefixIcon: Icon(Icons.electric_bolt),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _lengthController,
            keyboardType: const TextInputType.numberWithOptions(
              decimal: true,
            ),
            decoration: const InputDecoration(
              labelText: 'Longitud (m)',
              prefixIcon: Icon(Icons.straighten),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 8),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Material del conductor'),
            subtitle: Text(
              _copper ? 'Cobre' : 'Aluminio',
            ),
            secondary: const Icon(Icons.cable),
            value: _copper,
            onChanged: (value) {
              setState(() {
                _copper = value;
                _result = null;
              });
            },
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: _calculate,
            icon: const Icon(Icons.calculate),
            label: const Text('CALCULAR'),
          ),
          const SizedBox(height: 10),
          OutlinedButton.icon(
            onPressed: _clear,
            icon: const Icon(Icons.refresh),
            label: const Text('LIMPIAR'),
          ),
          if (_errorMessage != null) ...[
            const SizedBox(height: 18),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(
                      Icons.warning_amber,
                      color: Colors.orange,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(_errorMessage!),
                    ),
                  ],
                ),
              ),
            ),
          ],
          if (_result != null) ...[
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    _resultRow(
                      'Corriente',
                      '${_result!.current.toStringAsFixed(2)} A',
                    ),
                    _resultRow(
                      'Sección recomendada',
                      '${_formatSection(_result!.section)} mm²',
                    ),
                    _resultRow(
                      'Caída de tensión',
                      '${_result!.voltageDrop.toStringAsFixed(2)} V',
                    ),
                    _resultRow(
                      'Caída porcentual',
                      '${_result!.voltageDropPercent.toStringAsFixed(2)} %',
                    ),
                    const Divider(height: 28),
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
                    const SizedBox(height: 8),
                    const Text(
                      'Criterio de caída máxima configurado: 3 %',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _resultRow(
    String title,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 7,
      ),
      child: Row(
        children: [
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

  String _formatSection(double value) {
    if (value == value.roundToDouble()) {
      return value.toStringAsFixed(0);
    }

    return value.toStringAsFixed(1);
  }
}
