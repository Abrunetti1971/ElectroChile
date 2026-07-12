import 'package:flutter/material.dart';

import '../../components/ec_info_card.dart';
import '../../components/ec_result_card.dart';
import '../../components/ec_section_title.dart';

class CalculationResult extends StatelessWidget {
  final String resultado;
  final String unidad;
  final String formula;
  final String explicacion;
  final String interpretacion;

  const CalculationResult({
    super.key,
    required this.resultado,
    required this.unidad,
    required this.formula,
    required this.explicacion,
    required this.interpretacion,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const EcSectionTitle(
          titulo: "Resultado",
          icono: Icons.calculate,
        ),

        const SizedBox(height: 15),

        EcResultCard(
          titulo: "Resultado",
          resultado: resultado,
          unidad: unidad,
          formula: formula,
          descripcion: explicacion,
        ),

        const SizedBox(height: 20),

        EcInfoCard(
          titulo: "Interpretación técnica",
          descripcion: interpretacion,
          icono: Icons.engineering,
        ),

      ],
    );
  }
}