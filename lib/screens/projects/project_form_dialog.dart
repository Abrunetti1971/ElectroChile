import 'package:flutter/material.dart';

class ProjectFormDialog extends StatefulWidget {
  const ProjectFormDialog({super.key});

  @override
  State<ProjectFormDialog> createState() =>
      _ProjectFormDialogState();
}

class _ProjectFormDialogState
    extends State<ProjectFormDialog> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _clientController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _regionController = TextEditingController();
  final _distributorController =
  TextEditingController();
  final _notesController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _clientController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _regionController.dispose();
    _distributorController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    Navigator.pop(
      context,
      {
        "name": _nameController.text.trim(),
        "client": _clientController.text.trim(),
        "address": _addressController.text.trim(),
        "city": _cityController.text.trim(),
        "region": _regionController.text.trim(),
        "distributor":
        _distributorController.text.trim(),
        "notes": _notesController.text.trim(),
      },
    );
  }

  Widget _space() =>
      const SizedBox(height: 14);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom:
        MediaQuery.of(context).viewInsets.bottom +
            20,
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Nuevo Proyecto",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              _space(),

              TextFormField(
                controller: _nameController,
                decoration:
                const InputDecoration(
                  labelText:
                  "Nombre del proyecto",
                  prefixIcon:
                  Icon(Icons.folder),
                ),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return "Ingrese un nombre";
                  }

                  return null;
                },
              ),

              _space(),

              TextFormField(
                controller: _clientController,
                decoration:
                const InputDecoration(
                  labelText: "Cliente",
                  prefixIcon:
                  Icon(Icons.person),
                ),
              ),

              _space(),

              TextFormField(
                controller:
                _addressController,
                decoration:
                const InputDecoration(
                  labelText: "Dirección",
                  prefixIcon:
                  Icon(Icons.home),
                ),
              ),

              _space(),

              TextFormField(
                controller: _cityController,
                decoration:
                const InputDecoration(
                  labelText: "Comuna",
                  prefixIcon:
                  Icon(Icons.location_city),
                ),
              ),

              _space(),

              TextFormField(
                controller:
                _regionController,
                decoration:
                const InputDecoration(
                  labelText: "Región",
                  prefixIcon:
                  Icon(Icons.map),
                ),
              ),

              _space(),

              TextFormField(
                controller:
                _distributorController,
                decoration:
                const InputDecoration(
                  labelText:
                  "Distribuidora",
                  prefixIcon:
                  Icon(Icons.bolt),
                ),
              ),

              _space(),

              TextFormField(
                controller:
                _notesController,
                maxLines: 3,
                decoration:
                const InputDecoration(
                  labelText:
                  "Observaciones",
                  prefixIcon:
                  Icon(Icons.notes),
                ),
              ),

              const SizedBox(height: 25),

              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: _save,
                  icon:
                  const Icon(Icons.save),
                  label:
                  const Text("GUARDAR"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}