import 'package:flutter/material.dart';

class BaseCalculatorScreen extends StatelessWidget {

  final String titulo;

  final Widget formulario;

  final Widget? resultado;

  final Widget? acciones;

  final VoidCallback onCalcular;

  const BaseCalculatorScreen({

    super.key,

    required this.titulo,

    required this.formulario,

    required this.onCalcular,

    this.resultado,

    this.acciones,

  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: Text(titulo),

      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(20),

        child: Column(

          crossAxisAlignment:
          CrossAxisAlignment.stretch,

          children: [

            formulario,

            const SizedBox(height: 24),

            FilledButton.icon(

              onPressed: onCalcular,

              icon: const Icon(
                Icons.calculate,
              ),

              label: const Text(

                "CALCULAR",

                style: TextStyle(

                  fontWeight:
                  FontWeight.bold,

                  fontSize: 18,

                ),

              ),

            ),

            if (resultado != null) ...[

              const SizedBox(height: 30),

              resultado!,

            ],

            if (acciones != null) ...[

              const SizedBox(height: 30),

              acciones!,

            ],

            const SizedBox(height: 40),

          ],

        ),

      ),

    );

  }

}