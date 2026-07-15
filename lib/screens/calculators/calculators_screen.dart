import 'package:flutter/material.dart';

import 'conductor_screen.dart';
import 'ohm_screen.dart';
import 'power_screen.dart';
import 'voltage_drop_screen.dart';

class CalculatorsScreen extends StatelessWidget {
  const CalculatorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadoras"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          _item(
            context,
            Icons.electric_bolt,
            "Ley de Ohm",
            "Voltaje, Corriente, Resistencia y Potencia",
                () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const OhmScreen(),
                ),
              );
            },
          ),

          _item(
            context,
            Icons.flash_on,
            "Potencia",
            "Cálculo de potencia eléctrica",
                () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const PowerScreen(),
                ),
              );
            },
          ),

          _item(
            context,
            Icons.trending_down,
            "Caída de tensión",
            "Cálculo profesional según longitud y conductor",
                () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const VoltageDropScreen(),
                ),
              );
            },
          ),

          _item(
            context,
            Icons.cable,
            "Conductores",
            "Selección automática del conductor",
                () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ConductorScreen(),
                ),
              );
            },
          ),

          _item(
            context,
            Icons.bolt,
            "Corriente",
            "Próximamente",
                () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Disponible en la próxima versión."),
                ),
              );
            },
          ),

          _item(
            context,
            Icons.security,
            "Protecciones",
            "Próximamente",
                () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Disponible en la próxima versión."),
                ),
              );
            },
          ),

          _item(
            context,
            Icons.swap_horiz,
            "Conversor AWG",
            "Próximamente",
                () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Disponible en la próxima versión."),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _item(
      BuildContext context,
      IconData icon,
      String title,
      String subtitle,
      VoidCallback onTap,
      ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(icon),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}