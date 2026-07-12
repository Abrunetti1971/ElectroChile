import 'package:flutter/material.dart';

import '../voltage_drop_types.dart';

class VdInputForm extends StatelessWidget {
  final ConductorMaterial material;
  final SystemType sistema;

  final TextEditingController voltajeController;
  final TextEditingController corrienteController;
  final TextEditingController longitudController;

  final ValueChanged<ConductorMaterial> onMaterialChanged;
  final ValueChanged<SystemType> onSistemaChanged;

  const VdInputForm({
    super.key,
    required this.material,
    required this.sistema,
    required this.voltajeController,
    required this.corrienteController,
    required this.longitudController,
    required this.onMaterialChanged,
    required this.onSistemaChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const Text(
          "Material del conductor",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 10),

        RadioListTile<ConductorMaterial>(
          value: ConductorMaterial.cobre,
          groupValue: material,
          title: const Text("Cobre"),
          onChanged: (v) {
            if (v != null) {
              onMaterialChanged(v);
            }
          },
        ),

        RadioListTile<ConductorMaterial>(
          value: ConductorMaterial.aluminio,
          groupValue: material,
          title: const Text("Aluminio"),
          onChanged: (v) {
            if (v != null) {
              onMaterialChanged(v);
            }
          },
        ),

        const SizedBox(height: 20),

        const Text(
          "Sistema eléctrico",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 10),

        RadioListTile<SystemType>(
          value: SystemType.monofasico,
          groupValue: sistema,
          title: const Text("Monofásico"),
          onChanged: (v) {
            if (v != null) {
              onSistemaChanged(v);
            }
          },
        ),

        RadioListTile<SystemType>(
          value: SystemType.trifasico,
          groupValue: sistema,
          title: const Text("Trifásico"),
          onChanged: (v) {
            if (v != null) {
              onSistemaChanged(v);
            }
          },
        ),

        const SizedBox(height: 20),

        TextField(
          controller: voltajeController,
          keyboardType:
          const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(
            labelText: "Voltaje",
            suffixText: "V",
            border: OutlineInputBorder(),
          ),
        ),

        const SizedBox(height: 15),

        TextField(
          controller: corrienteController,
          keyboardType:
          const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(
            labelText: "Corriente",
            suffixText: "A",
            border: OutlineInputBorder(),
          ),
        ),

        const SizedBox(height: 15),

        TextField(
          controller: longitudController,
          keyboardType:
          const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(
            labelText: "Longitud",
            suffixText: "m",
            helperText: "Longitud de ida del circuito",
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}