import 'package:flutter/material.dart';

class PowerScreen extends StatefulWidget {
  const PowerScreen({super.key});

  @override
  State<PowerScreen> createState() => _PowerScreenState();
}

class _PowerScreenState extends State<PowerScreen> {
  final _voltage = TextEditingController();
  final _current = TextEditingController();

  String _result = '';

  @override
  void dispose() {
    _voltage.dispose();
    _current.dispose();
    super.dispose();
  }

  double? _value(TextEditingController controller) {
    final text = controller.text.replaceAll(',', '.').trim();

    if (text.isEmpty) {
      return null;
    }

    return double.tryParse(text);
  }

  void _calculate() {
    final voltage = _value(_voltage);
    final current = _value(_current);

    if (voltage == null || current == null) {
      setState(() {
        _result = 'Ingrese Voltaje y Corriente.';
      });
      return;
    }

    final power = voltage * current;

    setState(() {
      _result = '${power.toStringAsFixed(2)} W';
    });
  }

  void _clear() {
    _voltage.clear();
    _current.clear();

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
        title: const Text('Potencia'),
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
            const SizedBox(height: 25),
            if (_result.isNotEmpty)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.electric_bolt,
                        size: 34,
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Text(
                          'Potencia Calculada\n\n$_result',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
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