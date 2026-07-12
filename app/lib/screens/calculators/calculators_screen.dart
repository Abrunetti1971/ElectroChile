import 'package:flutter/material.dart';

import '../../widgets/ec_menu_tile.dart';
import 'ohm/ohm_screen.dart';

class CalculatorsScreen extends StatelessWidget {
  const CalculatorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadoras'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            "⚡ Calculadoras Eléctricas",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            "Selecciona la herramienta que deseas utilizar.",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 24),

          ECMenuTile(
            icon: Icons.electric_bolt,
            title: "Ley de Ohm",
            subtitle: "Voltaje • Corriente • Resistencia • Potencia",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const OhmScreen(),
                ),
              );
            },
          ),

          ECMenuTile(
            icon: Icons.flash_on,
            title: "Corriente",
            subtitle: "Calcular amperes desde Watts",
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Disponible próximamente"),
                ),
              );
            },
          ),

          ECMenuTile(
            icon: Icons.bolt,
            title: "Potencia",
            subtitle: "Calcular Watts",
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Disponible próximamente"),
                ),
              );
            },
          ),

          ECMenuTile(
            icon: Icons.show_chart,
            title: "Caída de Tensión",
            subtitle: "Según normativa SEC",
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Disponible próximamente"),
                ),
              );
            },
          ),

          ECMenuTile(
            icon: Icons.cable,
            title: "Conductores",
            subtitle: "Selección automática de mm²",
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Disponible próximamente"),
                ),
              );
            },
          ),

          ECMenuTile(
            icon: Icons.security,
            title: "Protecciones",
            subtitle: "Disyuntores y Diferenciales",
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Disponible próximamente"),
                ),
              );
            },
          ),

          ECMenuTile(
            icon: Icons.swap_horiz,
            title: "AWG ↔ mm²",
            subtitle: "Conversión de calibres",
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Disponible próximamente"),
                ),
              );
            },
          ),

          const SizedBox(height: 30),

          const Center(
            child: Text(
              "ElectroChile v1.0",
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}