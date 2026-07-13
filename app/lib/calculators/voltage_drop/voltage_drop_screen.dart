import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  State<VoltageDropScreen> createState() => _VoltageDropScreenState();
}

class _VoltageDropScreenState extends State<VoltageDropScreen> {
  final voltajeController = TextEditingController();
  final corrienteController = TextEditingController();
  final longitudController = TextEditingController();

  ConductorMaterial material = ConductorMaterial.cobre;
  SystemType sistema = SystemType.monofasico;

  VoltageDropResult? resultado;

  @override
  void dispose() {
    voltajeController.dispose();
    corrienteController.dispose();
    longitudController.dispose();
    super.dispose();
  }

  double numero(String texto) {
    return double.tryParse(
      texto.trim().replaceAll(",", "."),
    ) ??
        0;
  }

  void calcular() {
    FocusScope.of(context).unfocus();

    final voltaje = numero(voltajeController.text);
    final corriente = numero(corrienteController.text);
    final longitud = numero(longitudController.text);

    if (voltaje <= 0 || corriente <= 0 || longitud <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Ingrese todos los datos."),
        ),
      );
      return;
    }

    setState(() {
      resultado = VoltageDropService.calcular(
        voltaje: voltaje,
        corriente: corriente,
        longitud: longitud,
        cobre: material == ConductorMaterial.cobre,
        trifasico: sistema == SystemType.trifasico,
      );
    });
  }

  Future<void> compartir() async {
    if (resultado == null) return;

    await Clipboard.setData(
      ClipboardData(text: resultado!.observacion),
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Resultado copiado."),
      ),
    );
  }

  Future<void> guardarProyecto() async {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Guardado definitivo con SQLite disponible en la siguiente etapa.",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Caída de Tensión PRO"),
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
              VdResultCard(resultado: resultado!),
              const SizedBox(height: 20),
              VdSecCard(resultado: resultado!),
            ],
          ],
        ),
      ),
    );
  }
}