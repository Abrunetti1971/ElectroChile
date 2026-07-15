import 'package:flutter/material.dart';

import '../conductors_types.dart';

class ConductorsInputForm extends StatelessWidget {

final ConductorMaterial material;
final ElectricalSystem sistema;
final InstallationMethod metodo;
final InsulationType aislacion;
final double temperatura;
final int circuitosAgrupados;

final TextEditingController voltajeController;
final TextEditingController corrienteController;
final TextEditingController longitudController;

final ValueChanged<ConductorMaterial> onMaterialChanged;
final ValueChanged<ElectricalSystem> onSistemaChanged;
final ValueChanged<InstallationMethod> onMetodoChanged;
final ValueChanged<InsulationType> onAislacionChanged;
final ValueChanged<double> onTemperaturaChanged;
final ValueChanged<int> onAgrupamientoChanged;

const ConductorsInputForm({

super.key,

required this.material,
required this.sistema,
required this.metodo,
required this.aislacion,
required this.temperatura,
required this.circuitosAgrupados,

required this.voltajeController,
required this.corrienteController,
required this.longitudController,

required this.onMaterialChanged,
required this.onSistemaChanged,
required this.onMetodoChanged,
required this.onAislacionChanged,
required this.onTemperaturaChanged,
required this.onAgrupamientoChanged,

});

@override
Widget build(BuildContext context) {

return Column(

crossAxisAlignment:
CrossAxisAlignment.start,

children: [

const Text(

"DATOS DEL CIRCUITO",

style: TextStyle(

fontSize: 22,

fontWeight: FontWeight.bold,

),

),

const SizedBox(height: 20),

TextField(

controller: voltajeController,

keyboardType:
const TextInputType.numberWithOptions(
decimal: true,
),

decoration: const InputDecoration(

labelText: "Voltaje",

suffixText: "V",

border: OutlineInputBorder(),

),

),

const SizedBox(height: 16),

TextField(

controller: corrienteController,

keyboardType:
const TextInputType.numberWithOptions(
decimal: true,
),

decoration: const InputDecoration(

labelText: "Corriente",

suffixText: "A",

border: OutlineInputBorder(),

),

),

const SizedBox(height: 16),

TextField(

controller: longitudController,

keyboardType:
const TextInputType.numberWithOptions(
decimal: true,
),

decoration: const InputDecoration(

labelText: "Longitud",

suffixText: "m",

border: OutlineInputBorder(),

),

),

const SizedBox(height: 30),

const Text(

"MATERIAL",

style: TextStyle(

fontSize: 22,

fontWeight: FontWeight.bold,

),

),

const SizedBox(height: 15),
Wrap(

spacing: 12,

runSpacing: 12,

children: [

ChoiceChip(

label: const Text("🟧 Cobre"),

selected:
material ==
ConductorMaterial.cobre,

onSelected: (_) {

onMaterialChanged(
ConductorMaterial.cobre,
);

},

),

ChoiceChip(

label: const Text("⚪ Aluminio"),

selected:
material ==
ConductorMaterial.aluminio,

onSelected: (_) {

onMaterialChanged(
ConductorMaterial.aluminio,
);

},

),

],

),

const SizedBox(height: 30),

const Text(

"SISTEMA",

style: TextStyle(

fontSize: 22,

fontWeight: FontWeight.bold,

),

),

const SizedBox(height: 15),

Wrap(

spacing: 12,

runSpacing: 12,

children: [

ChoiceChip(

label: const Text(
"220V Monofásico",
),

selected:
sistema ==
ElectricalSystem.monofasico,

onSelected: (_) {

onSistemaChanged(
ElectricalSystem.monofasico,
);

},

),

ChoiceChip(

label: const Text(
"380V Trifásico",
),

selected:
sistema ==
ElectricalSystem.trifasico,

onSelected: (_) {

onSistemaChanged(
ElectricalSystem.trifasico,
);

},

),

],

),

const SizedBox(height: 30),

const Text(

"MÉTODO DE INSTALACIÓN",

style: TextStyle(

fontSize: 22,

fontWeight: FontWeight.bold,

),

),

const SizedBox(height: 15),

DropdownButtonFormField<InstallationMethod>(

value: metodo,

decoration: const InputDecoration(

border: OutlineInputBorder(),

),

items: InstallationMethod.values

.map(

(e) => DropdownMenuItem(

value: e,

child: Text(

e.name,

),

),

)

.toList(),

onChanged: (value) {

if (value != null) {

onMetodoChanged(value);

}

},

),

const SizedBox(height: 30),
  const Text(

    "TIPO DE AISLACIÓN",

    style: TextStyle(

      fontSize: 22,

      fontWeight: FontWeight.bold,

    ),

  ),

  const SizedBox(height: 15),

  DropdownButtonFormField<InsulationType>(

    value: aislacion,

    decoration: const InputDecoration(

      border: OutlineInputBorder(),

    ),

    items: InsulationType.values

        .map(

          (e) => DropdownMenuItem(

        value: e,

        child: Text(e.name.toUpperCase()),

      ),

    )

        .toList(),

    onChanged: (value) {

      if (value != null) {

        onAislacionChanged(value);

      }

    },

  ),

  const SizedBox(height: 30),

  const Text(

    "TEMPERATURA AMBIENTE",

    style: TextStyle(

      fontSize: 22,

      fontWeight: FontWeight.bold,

    ),

  ),

  const SizedBox(height: 15),

  DropdownButtonFormField<double>(

    value: temperatura,

    decoration: const InputDecoration(

      border: OutlineInputBorder(),

    ),

    items: const [

      25,

      30,

      35,

      40,

      45,

      50,

    ].map(

          (t) => DropdownMenuItem(

        value: t.toDouble(),

        child: Text("$t °C"),

      ),

    ).toList(),

    onChanged: (value) {

      if (value != null) {

        onTemperaturaChanged(value);

      }

    },

  ),

  const SizedBox(height: 30),

  const Text(

    "AGRUPAMIENTO",

    style: TextStyle(

      fontSize: 22,

      fontWeight: FontWeight.bold,

    ),

  ),

  const SizedBox(height: 15),

  DropdownButtonFormField<int>(

    value: circuitosAgrupados,

    decoration: const InputDecoration(

      border: OutlineInputBorder(),

    ),

    items: const [

      1,

      2,

      3,

      4,

      5,

    ].map(

          (cantidad) => DropdownMenuItem(

        value: cantidad,

        child: Text(

          cantidad == 5
              ? "5 o más circuitos"
              : "$cantidad circuito${cantidad > 1 ? 's' : ''}",

        ),

      ),

    ).toList(),

    onChanged: (value) {

      if (value != null) {

        onAgrupamientoChanged(value);

      }

    },

  ),

  const SizedBox(height: 30),

],

);

}

}