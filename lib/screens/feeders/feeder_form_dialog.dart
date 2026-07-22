import 'package:flutter/material.dart';

class FeederFormDialog extends StatefulWidget {
  const FeederFormDialog({super.key});

  @override
  State<FeederFormDialog> createState() => _FeederFormDialogState();
}

class _FeederFormDialogState extends State<FeederFormDialog> {
  final _formKey = GlobalKey<FormState>();

  final _name = TextEditingController();
  final _origin = TextEditingController(text: 'Empalme');
  final _destination = TextEditingController(text: 'Tablero General');
  final _length = TextEditingController(text: '10');

  @override
  void dispose() {
    _name.dispose();
    _origin.dispose();
    _destination.dispose();
    _length.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    Navigator.pop(context, {
      'name': _name.text.trim(),
      'origin': _origin.text.trim(),
      'destination': _destination.text.trim(),
      'length': double.tryParse(_length.text.replaceAll(',', '.')) ?? 0,
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
                'Nuevo Alimentador',
                style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),
              ),
              const SizedBox(height:20),
              TextFormField(
                controller:_name,
                decoration: const InputDecoration(labelText:'Nombre'),
                validator:(v)=>v==null||v.trim().isEmpty?'Ingrese un nombre':null,
              ),
              const SizedBox(height:12),
              TextFormField(
                controller:_origin,
                decoration: const InputDecoration(labelText:'Origen'),
              ),
              const SizedBox(height:12),
              TextFormField(
                controller:_destination,
                decoration: const InputDecoration(labelText:'Destino'),
              ),
              const SizedBox(height:12),
              TextFormField(
                controller:_length,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText:'Longitud (m)'),
              ),
              const SizedBox(height:20),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed:_save,
                  icon: const Icon(Icons.save),
                  label: const Text('GUARDAR'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
