import 'package:flutter/material.dart';

class EcInfoCard extends StatelessWidget {
  final String titulo;
  final String descripcion;
  final IconData icono;

  const EcInfoCard({
    super.key,
    required this.titulo,
    required this.descripcion,
    required this.icono,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            CircleAvatar(
              radius: 22,
              backgroundColor:
              Theme.of(context).primaryColor.withValues(alpha: 0.12),
              child: Icon(
                icono,
                color: Theme.of(context).primaryColor,
              ),
            ),

            const SizedBox(width: 15),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    titulo,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    descripcion,
                    style: const TextStyle(
                      fontSize: 15,
                      height: 1.5,
                    ),
                  ),

                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}