import 'package:flutter/material.dart';

class OhmScreen extends StatefulWidget {
  const OhmScreen({super.key});

  @override
  State<OhmScreen> createState() => _OhmScreenState();
}

class _OhmScreenState extends State<OhmScreen> {
  final _voltage = TextEditingController();
  final _current = TextEditingController();
  final _power = TextEditingController();
  final _resistance = TextEditingController();

  String _result = '';

  @override
  void dispose() {
    _voltage.dispose();
    _current.dispose();
    _power.dispose();
    _resistance.dispose();
    super.dispose();
  }

  double? _value(TextEditingController c) {
    final t = c.text.replaceAll(',', '.').trim();
    if (t.isEmpty) return null;
    return double.tryParse(t);
  }

  void _calculate() {
    final v = _value(_voltage);
    final i = _value(_current);
    final p = _value(_power);
    final r = _value(_resistance);

    String result = '';

    if (v != null && i != null) {
      result =
      'Potencia = ${(v * i).toStringAsFixed(2)} W\n'
          'Resistencia = ${(v / i).toStringAsFixed(2)} Ω';
    } else if (v != null && r != null) {
      final current = v / r;
      result =
      'Corriente = ${current.toStringAsFixed(2)} A\n'
          'Potencia = ${(v * current).toStringAsFixed(2)} W';
    } else if (p != null && v != null) {
      final current = p / v;
      result =
      'Corriente = ${current.toStringAsFixed(2)} A\n'
          'Resistencia = ${(v / current).toStringAsFixed(2)} Ω';
    } else if (p != null && i != null) {
      final voltage = p / i;
      result =
      'Voltaje = ${voltage.toStringAsFixed(2)} V\n'
          'Resistencia = ${(voltage / i).toStringAsFixed(2)} Ω';
    } else {
      result = 'Ingrese al menos dos valores.';
    }

    setState(() {
      _result = result;
    });
  }

  void _clear() {
    _voltage.clear();
    _current.clear();
    _power.clear();
    _resistance.clear();

    setState(() {
      _result = '';
    });
  }

  Widget _field(
      String label,
      String unit,
      IconData icon,
      TextEditingController controller,
      ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextField(
        controller: controller,
        keyboardType:
        const TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: '$label ($unit)',
          prefixIcon: Icon(icon),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ley de Ohm'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _field(
              'Voltaje',
              'V',
              Icons.bolt,
              _voltage,
            ),
            _field(
              'Corriente',
              'A',
              Icons.flash_on,
              _current,
            ),
            _field(
              'Potencia',
              'W',
              Icons.electric_bolt,
              _power,
            ),
            _field(
              'Resistencia',
              'Ω',
              Icons.cable,
              _resistance,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: _calculate,
                    icon: const Icon(Icons.calculate),
                    label: const Text('CALCULAR'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _clear,
                    icon: const Icon(Icons.refresh),
                    label: const Text('LIMPIAR'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (_result.isNotEmpty)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.check_circle,
                        size: 32,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _result,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}