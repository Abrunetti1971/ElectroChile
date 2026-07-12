import 'package:flutter/material.dart';

class EcSectionCard extends StatelessWidget {
  final String titulo;
  final Widget child;
  final IconData? icon;

  const EcSectionCard({
    super.key,
    required this.titulo,
    required this.child,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              children: [

                if (icon != null) ...[
                  Icon(
                    icon,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 10),
                ],

                Expanded(
                  child: Text(
                    titulo,
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

              ],
            ),

            const SizedBox(height: 10),

            const Divider(),

            const SizedBox(height: 8),

            child,

          ],
        ),
      ),
    );
  }
}