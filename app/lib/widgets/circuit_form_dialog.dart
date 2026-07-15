import 'package:flutter/material.dart';

import '../models/circuit.dart';

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

  CircuitType _type = CircuitType.lighting;

  double _voltage = 220;

  @override
  void dispose() {
    _name.dispose();
    _power.dispose();
    _length.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    Navigator.pop(
      context,
      {
        "name": _name.text.trim(),
        "type": _type,
        "voltage": _voltage,
        "power": double.parse(_power.text),
        "length": double.parse(_length.text),
      },
    );
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
                "Nuevo Circuito",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: _name,
                decoration: const InputDecoration(
                  labelText: "Nombre",
                ),
                validator: (v) =>
                v == null || v.isEmpty ? "Ingrese nombre" : null,
              ),

              const SizedBox(height: 15),

              DropdownButtonFormField<CircuitType>(
                initialValue: _type,
                decoration: const InputDecoration(
                  labelText: "Tipo",
                ),
                items: const [
                  DropdownMenuItem(
                    value: CircuitType.lighting,
                    child: Text("Alumbrado"),
                  ),
                  DropdownMenuItem(
                    value: CircuitType.outlets,
                    child: Text("Enchufes"),
                  ),
                  DropdownMenuItem(
                    value: CircuitType.motor,
                    child: Text("Motor"),
                  ),
                  DropdownMenuItem(
                    value: CircuitType.special,
                    child: Text("Especial"),
                  ),
                ],
                onChanged: (v) {
                  setState(() {
                    _type = v!;
                  });
                },
              ),

              const SizedBox(height: 15),

              DropdownButtonFormField<double>(
                initialValue: _voltage,
                decoration: const InputDecoration(
                  labelText: "Voltaje",
                ),
                items: const [
                  DropdownMenuItem(
                    value: 220,
                    child: Text("220 V"),
                  ),
                  DropdownMenuItem(
                    value: 380,
                    child: Text("380 V"),
                  ),
                ],
                onChanged: (v) {
                  setState(() {
                    _voltage = v!;
                  });
                },
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: _power,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Potencia (W)",
                ),
                validator: (v) =>
                v == null || v.isEmpty ? "Ingrese potencia" : null,
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: _length,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Longitud (m)",
                ),
                validator: (v) =>
                v == null || v.isEmpty ? "Ingrese longitud" : null,
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _save,
                  icon: const Icon(Icons.save),
                  label: const Text("CREAR CIRCUITO"),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}