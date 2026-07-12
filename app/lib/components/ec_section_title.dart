import 'package:flutter/material.dart';

class EcSectionTitle extends StatelessWidget {
  final String titulo;
  final IconData icono;

  const EcSectionTitle({
    super.key,
    required this.titulo,
    required this.icono,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icono,
          color: Theme.of(context).primaryColor,
          size: 26,
        ),
        const SizedBox(width: 10),
        Text(
          titulo,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}