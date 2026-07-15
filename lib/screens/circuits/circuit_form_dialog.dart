
import 'package:flutter/material.dart';

class CircuitFormDialog extends StatefulWidget {
  const CircuitFormDialog({super.key});

  @override
  State<CircuitFormDialog> createState() => _CircuitFormDialogState();
}

class _CircuitFormDialogState extends State<CircuitFormDialog> {
  final _formKey = GlobalKey<FormState>();

  final _name = TextEditingController();
  final _power = TextEditingController();
  final _length = TextEditingController();

  String _type = 'Alumbrado';
  String _voltage = '220';
  String _material = 'Cobre';
  String _section = '1.5';

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

  @override
  void dispose() {
    _name.dispose();
    _power.dispose();
    _length.dispose();
    super.dispose();
  }

  double get _current {
    final p = double.tryParse(_power.text.replaceAll(',', '.')) ?? 0;
    final v = double.tryParse(_voltage) ?? 220;
    if (v == 0) return 0;
    return p / v;
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    Navigator.pop(context, {
      'name': _name.text.trim(),
      'type': _type,
      'voltage': double.parse(_voltage),
      'power': double.tryParse(_power.text.replaceAll(',', '.')) ?? 0,
      'current': _current,
      'length': double.tryParse(_length.text.replaceAll(',', '.')) ?? 0,
      'conductorMaterial': _material,
      'conductorSection': double.parse(_section),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Nuevo Circuito',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _name,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  prefixIcon: Icon(Icons.electrical_services),
                ),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Ingrese un nombre' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _type,
                decoration: const InputDecoration(
                  labelText: 'Tipo',
                  prefixIcon: Icon(Icons.category),
                ),
                items: _types
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (v) => setState(() => _type = v!),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _voltage,
                decoration: const InputDecoration(
                  labelText: 'Voltaje',
                  prefixIcon: Icon(Icons.bolt),
                ),
                items: const [
                  DropdownMenuItem(value: '220', child: Text('220 V')),
                  DropdownMenuItem(value: '380', child: Text('380 V')),
                ],
                onChanged: (v) => setState(() => _voltage = v!),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _power,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Potencia (W)',
                  prefixIcon: Icon(Icons.flash_on),
                ),
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _length,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Longitud (m)',
                  prefixIcon: Icon(Icons.straighten),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _material,
                decoration: const InputDecoration(
                  labelText: 'Conductor',
                  prefixIcon: Icon(Icons.cable),
                ),
                items: const [
                  DropdownMenuItem(value: 'Cobre', child: Text('Cobre')),
                  DropdownMenuItem(value: 'Aluminio', child: Text('Aluminio')),
                ],
                onChanged: (v) => setState(() => _material = v!),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _section,
                decoration: const InputDecoration(
                  labelText: 'Sección',
                  prefixIcon: Icon(Icons.square_foot),
                ),
                items: const [
                  DropdownMenuItem(value: '1.5', child: Text('1.5 mm²')),
                  DropdownMenuItem(value: '2.5', child: Text('2.5 mm²')),
                  DropdownMenuItem(value: '4', child: Text('4 mm²')),
                  DropdownMenuItem(value: '6', child: Text('6 mm²')),
                ],
                onChanged: (v) => setState(() => _section = v!),
              ),
              const SizedBox(height: 20),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.calculate),
                  title: const Text('Corriente calculada'),
                  subtitle: Text('${_current.toStringAsFixed(2)} A'),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: _save,
                  icon: const Icon(Icons.save),
                  label: const Text('GUARDAR'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
