import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'power_service.dart';

enum PowerMode {
  power,
  voltage,
  current,
}

class PowerScreen extends StatefulWidget {
  const PowerScreen({super.key});

  @override
  State<PowerScreen> createState() => _PowerScreenState();
}

class _PowerScreenState extends State<PowerScreen> {

PowerMode mode = PowerMode.power;

final TextEditingController value1 = TextEditingController();
final TextEditingController value2 = TextEditingController();

String resultado = "";
String formula = "";
String descripcion = "";

@override
void dispose() {
value1.dispose();
value2.dispose();
super.dispose();
}

void limpiar() {

value1.clear();
value2.clear();

resultado = "";
formula = "";
descripcion = "";

setState(() {});

}

void copiarResultado() {

if (resultado.isEmpty) return;

Clipboard.setData(
ClipboardData(
text: "$resultado ${unidadResultado()}",
),
);

ScaffoldMessenger.of(context).showSnackBar(

const SnackBar(
content: Text("Resultado copiado al portapapeles."),
),

);

}

void calcular() {

final double a =
double.tryParse(value1.text.replaceAll(",", ".")) ?? 0;

final double b =
double.tryParse(value2.text.replaceAll(",", ".")) ?? 0;

if (a <= 0 || b <= 0) {

ScaffoldMessenger.of(context).showSnackBar(

const SnackBar(
content: Text("Ingrese valores válidos."),
),

);

return;

}

double r = 0;

switch (mode) {

case PowerMode.power:

r = PowerService.calcularPotencia(
voltaje: a,
corriente: b,
);

formula = "P = V × I";

descripcion =
"La potencia es el producto entre el voltaje y la corriente.";

break;

case PowerMode.voltage:

r = PowerService.calcularVoltaje(
potencia: a,
corriente: b,
);

formula = "V = P / I";

descripcion =
"El voltaje se obtiene dividiendo la potencia por la corriente.";

break;

case PowerMode.current:

r = PowerService.calcularCorriente(
potencia: a,
voltaje: b,
);

formula = "I = P / V";

descripcion =
"La corriente se obtiene dividiendo la potencia por el voltaje.";

break;

}

resultado = r.toStringAsFixed(2);

setState(() {});

}

String label1() {

switch (mode) {

case PowerMode.power:
return "Voltaje";

case PowerMode.voltage:
return "Potencia";

case PowerMode.current:
return "Potencia";

}

}

String label2() {

switch (mode) {

case PowerMode.power:
return "Corriente";

case PowerMode.voltage:
return "Corriente";

case PowerMode.current:
return "Voltaje";

}

}

String unidad1() {

switch (mode) {

case PowerMode.power:
return "V";

case PowerMode.voltage:
return "W";

case PowerMode.current:
return "W";

}

}

String unidad2() {

switch (mode) {

case PowerMode.power:
return "A";

case PowerMode.voltage:
return "A";

case PowerMode.current:
return "V";

}

}

String unidadResultado() {

switch (mode) {

case PowerMode.power:
return "W";

case PowerMode.voltage:
return "V";

case PowerMode.current:
return "A";

}

}
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text("Potencia PRO"),
      actions: [
        IconButton(
          onPressed: limpiar,
          icon: const Icon(Icons.refresh),
        ),
        IconButton(
          onPressed: copiarResultado,
          icon: const Icon(Icons.copy),
        ),
      ],
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Text(
            "¿Qué desea calcular?",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 15),

          RadioListTile(
            title: const Text("Potencia (W)"),
            value: PowerMode.power,
            groupValue: mode,
            onChanged: (v) {
              setState(() {
                mode = v!;
                limpiar();
              });
            },
          ),

          RadioListTile(
            title: const Text("Voltaje (V)"),
            value: PowerMode.voltage,
            groupValue: mode,
            onChanged: (v) {
              setState(() {
                mode = v!;
                limpiar();
              });
            },
          ),

          RadioListTile(
            title: const Text("Corriente (A)"),
            value: PowerMode.current,
            groupValue: mode,
            onChanged: (v) {
              setState(() {
                mode = v!;
                limpiar();
              });
            },
          ),

          const SizedBox(height: 20),

          TextField(
            controller: value1,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: label1(),
              suffixText: unidad1(),
              border: const OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 15),

          TextField(
            controller: value2,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: label2(),
              suffixText: unidad2(),
              border: const OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 25),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: calcular,
              icon: const Icon(Icons.calculate),
              label: const Text("Calcular"),
            ),
          ),

          const SizedBox(height: 25),

          if (resultado.isNotEmpty)
            Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [

                    const Text(
                      "Resultado",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 15),

                    Text(
                      "$resultado ${unidadResultado()}",
                      style: const TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),

                    const SizedBox(height: 20),

                    Text(
                      formula,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      descripcion,
                      textAlign: TextAlign.center,
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