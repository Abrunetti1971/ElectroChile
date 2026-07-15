import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/colors.dart';
import '../../../services/electrical_calculator.dart';
import '../../../widgets/ec_text_field.dart';

enum OhmCalculation {
  current,
  voltage,
  power,
  resistance,
}

class OhmScreen extends StatefulWidget {
  const OhmScreen({super.key});

  @override
  State<OhmScreen> createState() => _OhmScreenState();
}

class _OhmScreenState extends State<OhmScreen> {
  final TextEditingController firstController = TextEditingController();
  final TextEditingController secondController = TextEditingController();

  OhmCalculation selectedCalculation = OhmCalculation.current;

  double? result;
  String resultName = '';
  String resultUnit = '';
  String formula = '';
  String errorMessage = '';

  String get firstLabel {
    switch (selectedCalculation) {
      case OhmCalculation.current:
        return 'Voltaje (V)';
      case OhmCalculation.voltage:
        return 'Corriente (A)';
      case OhmCalculation.power:
        return 'Voltaje (V)';
      case OhmCalculation.resistance:
        return 'Voltaje (V)';
    }
  }

  String get secondLabel {
    switch (selectedCalculation) {
      case OhmCalculation.current:
        return 'Potencia (W)';
      case OhmCalculation.voltage:
        return 'Resistencia (Ω)';
      case OhmCalculation.power:
        return 'Corriente (A)';
      case OhmCalculation.resistance:
        return 'Corriente (A)';
    }
  }

  IconData get firstIcon {
    switch (selectedCalculation) {
      case OhmCalculation.current:
      case OhmCalculation.power:
      case OhmCalculation.resistance:
        return Icons.electric_bolt;
      case OhmCalculation.voltage:
        return Icons.speed;
    }
  }

  IconData get secondIcon {
    switch (selectedCalculation) {
      case OhmCalculation.current:
        return Icons.power;
      case OhmCalculation.voltage:
        return Icons.timeline;
      case OhmCalculation.power:
      case OhmCalculation.resistance:
        return Icons.speed;
    }
  }

  double? _parseNumber(String text) {
    final normalizedText = text.trim().replaceAll(',', '.');
    return double.tryParse(normalizedText);
  }

  void _changeCalculation(OhmCalculation calculation) {
    setState(() {
      selectedCalculation = calculation;
      firstController.clear();
      secondController.clear();
      result = null;
      resultName = '';
      resultUnit = '';
      formula = '';
      errorMessage = '';
    });
  }

  void _calculate() {
    FocusScope.of(context).unfocus();

    final firstValue = _parseNumber(firstController.text);
    final secondValue = _parseNumber(secondController.text);

    if (firstValue == null || secondValue == null) {
      setState(() {
        result = null;
        errorMessage = 'Ingresa valores numéricos válidos.';
      });
      return;
    }

    if (firstValue <= 0 || secondValue <= 0) {
      setState(() {
        result = null;
        errorMessage = 'Los valores deben ser mayores que cero.';
      });
      return;
    }

    double calculatedResult;
    String calculatedName;
    String calculatedUnit;
    String usedFormula;

    switch (selectedCalculation) {
      case OhmCalculation.current:
        calculatedResult = ElectricalCalculator.current(
          voltage: firstValue,
          power: secondValue,
        );
        calculatedName = 'Corriente';
        calculatedUnit = 'A';
        usedFormula = 'I = P ÷ V';
        break;

      case OhmCalculation.voltage:
        calculatedResult = ElectricalCalculator.voltage(
          current: firstValue,
          resistance: secondValue,
        );
        calculatedName = 'Voltaje';
        calculatedUnit = 'V';
        usedFormula = 'V = I × R';
        break;

      case OhmCalculation.power:
        calculatedResult = ElectricalCalculator.power(
          voltage: firstValue,
          current: secondValue,
        );
        calculatedName = 'Potencia';
        calculatedUnit = 'W';
        usedFormula = 'P = V × I';
        break;

      case OhmCalculation.resistance:
        calculatedResult = ElectricalCalculator.resistance(
          voltage: firstValue,
          current: secondValue,
        );
        calculatedName = 'Resistencia';
        calculatedUnit = 'Ω';
        usedFormula = 'R = V ÷ I';
        break;
    }

    setState(() {
      result = calculatedResult;
      resultName = calculatedName;
      resultUnit = calculatedUnit;
      formula = usedFormula;
      errorMessage = '';
    });
  }

  void _clear() {
    FocusScope.of(context).unfocus();

    firstController.clear();
    secondController.clear();

    setState(() {
      result = null;
      resultName = '';
      resultUnit = '';
      formula = '';
      errorMessage = '';
    });
  }

  Future<void> _copyResult() async {
    if (result == null) {
      return;
    }

    final text =
        '$resultName: ${_formatNumber(result!)} $resultUnit\nFórmula: $formula';

    await Clipboard.setData(
      ClipboardData(text: text),
    );

    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Resultado copiado al portapapeles.'),
      ),
    );
  }

  String _formatNumber(double value) {
    if (value.abs() >= 1000) {
      return value.toStringAsFixed(1);
    }

    if (value.abs() >= 100) {
      return value.toStringAsFixed(2);
    }

    return value.toStringAsFixed(3);
  }

  @override
  void dispose() {
    firstController.dispose();
    secondController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ley de Ohm PRO'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildHeader(),

          const SizedBox(height: 28),

          const Text(
            '¿Qué deseas calcular?',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: ECColors.textPrimary,
            ),
          ),

          const SizedBox(height: 14),

          _buildSelector(),

          const SizedBox(height: 28),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                children: [
                  ECTextField(
                    controller: firstController,
                    label: firstLabel,
                    hint: 'Ejemplo: 220',
                    icon: firstIcon,
                  ),

                  const SizedBox(height: 18),

                  ECTextField(
                    controller: secondController,
                    label: secondLabel,
                    hint: 'Ingresa el segundo valor',
                    icon: secondIcon,
                  ),
                ],
              ),
            ),
          ),

          if (errorMessage.isNotEmpty) ...[
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: ECColors.error.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: ECColors.error.withValues(alpha: 0.35),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: ECColors.error,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      errorMessage,
                      style: const TextStyle(
                        color: ECColors.error,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],

          const SizedBox(height: 24),

          ElevatedButton.icon(
            onPressed: _calculate,
            icon: const Icon(Icons.calculate),
            label: const Text('CALCULAR'),
          ),

          const SizedBox(height: 12),

          OutlinedButton.icon(
            onPressed: _clear,
            icon: const Icon(Icons.refresh),
            label: const Text('NUEVO CÁLCULO'),
          ),

          if (result != null) ...[
            const SizedBox(height: 28),
            _buildResultCard(),
          ],

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: ECColors.primary,
        borderRadius: BorderRadius.circular(22),
      ),
      child: const Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: ECColors.secondary,
            child: Icon(
              Icons.electric_bolt,
              size: 36,
              color: ECColors.primaryDark,
            ),
          ),
          SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'LEY DE OHM',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Cálculos eléctricos rápidos y precisos',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelector() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        _calculationChip(
          calculation: OhmCalculation.current,
          label: 'Corriente',
          unit: 'A',
          icon: Icons.speed,
        ),
        _calculationChip(
          calculation: OhmCalculation.voltage,
          label: 'Voltaje',
          unit: 'V',
          icon: Icons.electric_bolt,
        ),
        _calculationChip(
          calculation: OhmCalculation.power,
          label: 'Potencia',
          unit: 'W',
          icon: Icons.power,
        ),
        _calculationChip(
          calculation: OhmCalculation.resistance,
          label: 'Resistencia',
          unit: 'Ω',
          icon: Icons.timeline,
        ),
      ],
    );
  }

  Widget _calculationChip({
    required OhmCalculation calculation,
    required String label,
    required String unit,
    required IconData icon,
  }) {
    final isSelected = selectedCalculation == calculation;

    return ChoiceChip(
      selected: isSelected,
      onSelected: (_) => _changeCalculation(calculation),
      avatar: Icon(
        icon,
        size: 19,
        color: isSelected ? Colors.white : ECColors.primary,
      ),
      label: Text('$label ($unit)'),
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : ECColors.textPrimary,
        fontWeight: FontWeight.w600,
      ),
      selectedColor: ECColors.primary,
      backgroundColor: ECColors.surface,
      side: BorderSide(
        color: isSelected ? ECColors.primary : ECColors.cardBorder,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      showCheckmark: false,
    );
  }

  Widget _buildResultCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'RESULTADO',
              style: TextStyle(
                color: ECColors.textSecondary,
                fontSize: 13,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),

            const SizedBox(height: 16),

            Text(
              resultName,
              style: const TextStyle(
                color: ECColors.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              '${_formatNumber(result!)} $resultUnit',
              style: const TextStyle(
                color: ECColors.primary,
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),

            const Divider(height: 34),

            const Text(
              'Fórmula utilizada',
              style: TextStyle(
                color: ECColors.textSecondary,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 7),

            Text(
              formula,
              style: const TextStyle(
                color: ECColors.textPrimary,
                fontSize: 21,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 20),

            OutlinedButton.icon(
              onPressed: _copyResult,
              icon: const Icon(Icons.copy),
              label: const Text('COPIAR RESULTADO'),
            ),
          ],
        ),
      ),
    );
  }
}