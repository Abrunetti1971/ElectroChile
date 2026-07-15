import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../components/ec_button.dart';
import '../../components/ec_input.dart';
import '../../components/ec_result_card.dart';
import '../../core/engineering/electrical_analysis.dart';
import '../../core/engineering/engineering_engine.dart';
import '../../services/ohm_service.dart';

enum OhmMode {
  voltage,
  current,
  resistance,
}

class OhmScreen extends StatefulWidget {
  const OhmScreen({super.key});

  @override
  State<OhmScreen> createState() => _OhmScreenState();
}

class _OhmScreenState extends State<OhmScreen> {
  OhmMode modo = OhmMode.voltage;

  final TextEditingController valor1 = TextEditingController();
  final TextEditingController valor2 = TextEditingController();

  String resultado = "";
  String formula = "";
  String descripcion = "";

  ElectricalAnalysis? analysis;

  @override
  void dispose() {
    valor1.dispose();
    valor2.dispose();
    super.dispose();
  }

  void limpiar() {
    setState(() {
      valor1.clear();
      valor2.clear();
      resultado = "";
      formula = "";
      descripcion = "";
      analysis = null;
    });
  }

  void cambiarModo(OhmMode nuevoModo) {
    setState(() {
      modo = nuevoModo;
      valor1.clear();
      valor2.clear();
      resultado = "";
      formula = "";
      descripcion = "";
      analysis = null;
    });
  }

  void calcular() {
    final double a = double.tryParse(valor1.text.replaceAll(",", ".")) ?? 0;
    final double b = double.tryParse(valor2.text.replaceAll(",", ".")) ?? 0;

    if (a <= 0 || b <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Ingrese valores válidos."),
        ),
      );
      return;
    }

    double r;

    switch (modo) {
      case OhmMode.voltage:
        r = OhmService.calcularVoltaje(
          corriente: a,
          resistencia: b,
        );

        formula = "V = I × R";
        descripcion =
        "Con una corriente de ${a.toStringAsFixed(2)} A y una resistencia de ${b.toStringAsFixed(2)} Ω, el voltaje requerido es ${r.toStringAsFixed(2)} V.";

        analysis = EngineeringEngine.analyzeOhm(
          current: a,
          resistance: b,
        );
        break;

      case OhmMode.current:
        r = OhmService.calcularCorriente(
          voltaje: a,
          resistencia: b,
        );

        formula = "I = V / R";
        descripcion =
        "Con un voltaje de ${a.toStringAsFixed(2)} V y una resistencia de ${b.toStringAsFixed(2)} Ω, la corriente estimada es ${r.toStringAsFixed(2)} A.";

        analysis = EngineeringEngine.analyzeOhm(
          voltage: a,
          resistance: b,
        );
        break;

      case OhmMode.resistance:
        r = OhmService.calcularResistencia(
          voltaje: a,
          corriente: b,
        );

        formula = "R = V / I";
        descripcion =
        "Con un voltaje de ${a.toStringAsFixed(2)} V y una corriente de ${b.toStringAsFixed(2)} A, la resistencia equivalente es ${r.toStringAsFixed(2)} Ω.";

        analysis = EngineeringEngine.analyzeOhm(
          voltage: a,
          current: b,
        );
        break;
    }

    setState(() {
      resultado = r.toStringAsFixed(2);
    });
  }

  void copiarResultado() {
    if (resultado.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Primero debe realizar un cálculo."),
        ),
      );
      return;
    }

    final String textoCopiado = '''
ElectroChile - Ley de Ohm PRO

Resultado: $resultado ${unidadResultado()}
Fórmula: $formula

$descripcion

${analysis != null ? "Potencia aproximada: ${analysis!.power?.toStringAsFixed(2)} W" : ""}
${analysis != null ? "Nota técnica: ${analysis!.technicalNote}" : ""}

Generado por ElectroChile.
''';

    Clipboard.setData(
      ClipboardData(text: textoCopiado),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Resultado copiado al portapapeles."),
      ),
    );
  }

  String label1() {
    switch (modo) {
      case OhmMode.voltage:
        return "Corriente";
      case OhmMode.current:
        return "Voltaje";
      case OhmMode.resistance:
        return "Voltaje";
    }
  }

  String unidad1() {
    switch (modo) {
      case OhmMode.voltage:
        return "A";
      case OhmMode.current:
        return "V";
      case OhmMode.resistance:
        return "V";
    }
  }

  String label2() {
    switch (modo) {
      case OhmMode.voltage:
        return "Resistencia";
      case OhmMode.current:
        return "Resistencia";
      case OhmMode.resistance:
        return "Corriente";
    }
  }

  String unidad2() {
    switch (modo) {
      case OhmMode.voltage:
        return "Ω";
      case OhmMode.current:
        return "Ω";
      case OhmMode.resistance:
        return "A";
    }
  }

  String unidadResultado() {
    switch (modo) {
      case OhmMode.voltage:
        return "V";
      case OhmMode.current:
        return "A";
      case OhmMode.resistance:
        return "Ω";
    }
  }

  Widget _analysisCard() {
    if (analysis == null) {
      return const SizedBox.shrink();
    }

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Análisis técnico",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            if (analysis!.power != null)
              Text(
                "Potencia aproximada: ${analysis!.power!.toStringAsFixed(2)} W",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

            const SizedBox(height: 12),

            Text(
              analysis!.explanation,
              style: const TextStyle(
                fontSize: 15,
                height: 1.4,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              analysis!.technicalNote,
              style: const TextStyle(
                fontSize: 15,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ley de Ohm PRO"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "¿Qué desea calcular?",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            RadioListTile(
              title: const Text("Voltaje (V)"),
              value: OhmMode.voltage,
              groupValue: modo,
              onChanged: (value) => cambiarModo(value!),
            ),

            RadioListTile(
              title: const Text("Corriente (A)"),
              value: OhmMode.current,
              groupValue: modo,
              onChanged: (value) => cambiarModo(value!),
            ),

            RadioListTile(
              title: const Text("Resistencia (Ω)"),
              value: OhmMode.resistance,
              groupValue: modo,
              onChanged: (value) => cambiarModo(value!),
            ),

            const SizedBox(height: 20),

            EcInput(
              controller: valor1,
              label: label1(),
              hint: "Ingrese ${label1().toLowerCase()}",
              icon: Icons.flash_on,
              suffix: Text(unidad1()),
            ),

            const SizedBox(height: 15),

            EcInput(
              controller: valor2,
              label: label2(),
              hint: "Ingrese ${label2().toLowerCase()}",
              icon: Icons.electric_bolt,
              suffix: Text(unidad2()),
            ),

            const SizedBox(height: 25),

            EcButton(
              texto: "Calcular",
              icono: Icons.calculate,
              onPressed: calcular,
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton.icon(
                onPressed: limpiar,
                icon: const Icon(Icons.refresh),
                label: const Text(
                  "Limpiar",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            if (resultado.isNotEmpty) ...[
              EcResultCard(
                titulo: "Resultado",
                resultado: resultado,
                unidad: unidadResultado(),
                formula: formula,
                descripcion: descripcion,
              ),

              const SizedBox(height: 15),

              _analysisCard(),

              const SizedBox(height: 15),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton.icon(
                  onPressed: copiarResultado,
                  icon: const Icon(Icons.copy),
                  label: const Text(
                    "Copiar resultado",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}