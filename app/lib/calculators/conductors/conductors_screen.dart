import 'package:flutter/material.dart';

import '../../components/base_calculator_screen.dart';

import 'conductors_result.dart';
import 'conductors_service.dart';
import 'conductors_types.dart';

import 'widgets/conductors_action_buttons.dart';
import 'widgets/conductors_input_form.dart';
import 'widgets/conductors_result_card.dart';
import 'widgets/conductors_sec_card.dart';

class ConductorsScreen extends StatefulWidget {

  const ConductorsScreen({
    super.key,
  });

  @override
  State<ConductorsScreen> createState() =>
      _ConductorsScreenState();

}

class _ConductorsScreenState
    extends State<ConductorsScreen> {

//--------------------------------------------------
// Estado
//--------------------------------------------------

  ConductorMaterial material =
      ConductorMaterial.cobre;

  ElectricalSystem sistema =
      ElectricalSystem.monofasico;

  InstallationMethod metodo =
      InstallationMethod.ductoPvc;

  InsulationType aislacion =
      InsulationType.pvc;

  double temperatura = 30;

  int circuitosAgrupados = 1;

  ConductorsResult? resultado;

//--------------------------------------------------
// Controllers
//--------------------------------------------------

  final voltajeController =
  TextEditingController();

  final corrienteController =
  TextEditingController();

  final longitudController =
  TextEditingController();

//--------------------------------------------------
// Ciclo de vida
//--------------------------------------------------

  @override
  void dispose() {
    voltajeController.dispose();

    corrienteController.dispose();

    longitudController.dispose();

    super.dispose();
  }

//--------------------------------------------------
// Calcular
//--------------------------------------------------

  void _calcular() {
    final double voltaje =
        double.tryParse(
          voltajeController.text.replaceAll(',', '.'),
        ) ??
            0;

    final double corriente =
        double.tryParse(
          corrienteController.text.replaceAll(',', '.'),
        ) ??
            0;

    final double longitud =
        double.tryParse(
          longitudController.text.replaceAll(',', '.'),
        ) ??
            0;

    if (voltaje <= 0 ||
        corriente <= 0 ||
        longitud <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(

          content: Text(
            "Ingrese todos los datos correctamente.",
          ),

        ),

      );

      return;
    }

    setState(() {
      resultado = ConductorsService.calcular(

        voltaje: voltaje,

        corriente: corriente,

        longitud: longitud,

        material: material,

        sistema: sistema,

        metodo: metodo,

        aislacion: aislacion,

        temperatura: temperatura,

        circuitosAgrupados:
        circuitosAgrupados,

      );
    });
  }

//--------------------------------------------------
// UI
//--------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return BaseCalculatorScreen(

      titulo: "Conductores PRO",

      onCalcular: _calcular,

      formulario: ConductorsInputForm(

        material: material,

        sistema: sistema,

        metodo: metodo,

        aislacion: aislacion,

        temperatura: temperatura,

        circuitosAgrupados: circuitosAgrupados,

        voltajeController: voltajeController,

        corrienteController: corrienteController,

        longitudController: longitudController,

        onMaterialChanged: (valor) {
          setState(() {
            material = valor;
          });
        },

        onSistemaChanged: (valor) {
          setState(() {
            sistema = valor;
          });
        },

        onMetodoChanged: (valor) {
          setState(() {
            metodo = valor;
          });
        },

        onAislacionChanged: (valor) {
          setState(() {
            aislacion = valor;
          });
        },

        onTemperaturaChanged: (valor) {
          setState(() {
            temperatura = valor;
          });
        },

        onAgrupamientoChanged: (valor) {
          setState(() {
            circuitosAgrupados = valor;
          });
        },

      ),
      resultado: resultado == null
          ? null
          : Column(

        children: [

          ConductorsResultCard(

            resultado: resultado!,

          ),

          const SizedBox(height: 20),

          ConductorsSecCard(

            resultado: resultado!,

          ),

        ],

      ),

      acciones: resultado == null

          ? null

          : ConductorsActionButtons(

        resultado: resultado!,

      ),

    );
  }
}