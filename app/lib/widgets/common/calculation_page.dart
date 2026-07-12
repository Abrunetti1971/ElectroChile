import 'package:flutter/material.dart';

class CalculationPage extends StatelessWidget {
  final String titulo;
  final Widget selector;
  final Widget inputs;
  final Widget botones;
  final Widget? resultado;

  const CalculationPage({
    super.key,
    required this.titulo,
    required this.selector,
    required this.inputs,
    required this.botones,
    this.resultado,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titulo),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// Selector
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: selector,
                ),
              ),

              const SizedBox(height: 20),

              /// Datos
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: inputs,
                ),
              ),

              const SizedBox(height: 20),

              botones,

              if (resultado != null) ...[
                const SizedBox(height: 25),
                resultado!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}