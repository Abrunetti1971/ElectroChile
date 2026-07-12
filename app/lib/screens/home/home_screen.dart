import 'package:flutter/material.dart';

import '../calculators/calculators_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ElectroChile"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 10),

          const Icon(
            Icons.bolt,
            size: 90,
            color: Colors.amber,
          ),

          const SizedBox(height: 15),

          const Center(
            child: Text(
              "Herramientas para Instaladores Eléctricos",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 30),

          SizedBox(
            height: 60,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.calculate),
              label: const Text("Calculadoras"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CalculatorsScreen(),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 12),

          SizedBox(
            height: 60,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.folder),
              label: const Text("Mis Proyectos"),
              onPressed: () {},
            ),
          ),

          const SizedBox(height: 12),

          SizedBox(
            height: 60,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.menu_book),
              label: const Text("Biblioteca SEC"),
              onPressed: () {},
            ),
          ),

          const SizedBox(height: 12),

          SizedBox(
            height: 60,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.settings),
              label: const Text("Configuración"),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}