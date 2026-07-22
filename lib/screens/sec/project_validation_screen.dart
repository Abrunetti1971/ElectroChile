import 'package:flutter/material.dart';

class ProjectValidationScreen extends StatelessWidget {
  const ProjectValidationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Validación del Proyecto'),
      ),
      body: const Center(
        child: Text(
          'Centro de Validación SEC',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
