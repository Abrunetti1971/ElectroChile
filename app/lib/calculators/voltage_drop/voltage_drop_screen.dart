import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../database/database_service.dart';
import '../../models/electrical_project.dart';
import '../../services/project_factory.dart';

import 'voltage_drop_result.dart';
import 'voltage_drop_service.dart';
import 'voltage_drop_types.dart';

import 'widgets/vd_action_buttons.dart';
import 'widgets/vd_input_form.dart';
import 'widgets/vd_result_card.dart';
import 'widgets/vd_sec_card.dart';

class VoltageDropScreen extends StatefulWidget {
  const VoltageDropScreen({super.key});

  @override
  State<VoltageDropScreen> createState() =>
      _VoltageDropScreenState();
}

class _VoltageDropScreenState
    extends State<VoltageDropScreen> {

final TextEditingController voltajeController =
TextEditingController();

final TextEditingController corrienteController =
TextEditingController();

final TextEditingController longitudController =
TextEditingController();

ConductorMaterial material =
ConductorMaterial.cobre;

SystemType sistema =
SystemType.monofasico;

VoltageDropResult? resultado;

@override
void dispose() {

voltajeController.dispose();

corrienteController.dispose();

longitudController.dispose();

super.dispose();

}

double numero(String texto){

return double.tryParse(

texto.trim().replaceAll(",", "."),

) ?? 0;

}

void calcular(){

FocusScope.of(context).unfocus();

final double voltaje =
numero(
voltajeController.text,
);

final double corriente =
numero(
corrienteController.text,
);

final double longitud =
numero(
longitudController.text,
);

if(

voltaje<=0 ||

corriente<=0 ||

longitud<=0

){

ScaffoldMessenger.of(context)

.showSnackBar(

const SnackBar(

content: Text(

"Ingrese todos los datos.",

),

),

);

return;

}

final nuevoResultado =

VoltageDropService.calcular(

voltaje: voltaje,

corriente: corriente,

longitud: longitud,

cobre:
material ==
ConductorMaterial.cobre,

trifasico:
sistema ==
SystemType.trifasico,

);

setState(() {

resultado = nuevoResultado;

});

}
void compartir() {

if (resultado == null) {
return;
}

Clipboard.setData(
ClipboardData(
text: resultado!.observacion,
),
);

ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(
content: Text(
"Resultado copiado al portapapeles.",
),
),
);
}

Future<void> guardarProyecto() async {

if (resultado == null) {
return;
}

final controller = TextEditingController();

final String? nombre = await showDialog<String>(
context: context,
builder: (context) {

return AlertDialog(

title: const Text(
"Guardar proyecto",
),

content: TextField(

controller: controller,

autofocus: true,

decoration: const InputDecoration(

labelText: "Nombre del proyecto",

border: OutlineInputBorder(),

),

),

actions: [

TextButton(

onPressed: () {

Navigator.pop(context);

},

child: const Text("Cancelar"),

),

FilledButton(

onPressed: () {

Navigator.pop(
context,
controller.text.trim(),
);

},

child: const Text("Guardar"),

),

],

);

},

);

if (nombre == null) return;

final ElectricalProject proyecto =
ProjectFactory.fromVoltageDrop(

nombre: nombre.isEmpty
? "Proyecto sin nombre"
: nombre,

resultado: resultado!,

);

DatabaseService.instance.guardarProyecto(
proyecto,
);

if (!mounted) return;

ScaffoldMessenger.of(context).showSnackBar(

SnackBar(

content: Text(
"Proyecto '${proyecto.nombre}' guardado correctamente.",
),

),

);

}

@override
Widget build(BuildContext context) {

return Scaffold(

appBar: AppBar(

title: const Text(
"Caída de Tensión PRO",
),

),

body: SingleChildScrollView(

padding: const EdgeInsets.all(20),

child: Column(

crossAxisAlignment: CrossAxisAlignment.start,

children: [

VdInputForm(

material: material,

sistema: sistema,

voltajeController: voltajeController,

corrienteController: corrienteController,

longitudController: longitudController,

onMaterialChanged: (nuevo) {

setState(() {

material = nuevo;

resultado = null;

});

},

onSistemaChanged: (nuevo) {

setState(() {

sistema = nuevo;

resultado = null;

});

},

),

const SizedBox(height: 25),

VdActionButtons(

onCalcular: calcular,

onCompartir: compartir,

onGuardar: guardarProyecto,

),

const SizedBox(height: 25),
  if (resultado != null) ...[

    VdResultCard(
      resultado: resultado!,
    ),

    const SizedBox(height: 20),

    VdSecCard(
      resultado: resultado!,
    ),

  ],

  const SizedBox(height: 40),

],

),

),

);

}

}