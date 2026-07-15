import 'package:flutter/material.dart';

import '../calculators/calculators_screen.dart';
import '../projects/projects_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ElectroChile PRO'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            elevation: 2,
            color: Theme.of(context).colorScheme.primaryContainer,
            child: const Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '⚡ ElectroChile PRO',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Hecho por instaladores, para instaladores.',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          _MenuCard(
            icon: Icons.folder_copy,
            title: 'Mis Proyectos',
            subtitle: 'Crear y administrar proyectos',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ProjectsScreen(),
                ),
              );
            },
          ),

          _MenuCard(
            icon: Icons.calculate,
            title: 'Calculadoras',
            subtitle: 'Ley de Ohm, Potencia, Corriente y más',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const CalculatorsScreen(),
                ),
              );
            },
          ),

          _MenuCard(
            icon: Icons.menu_book,
            title: 'Biblioteca SEC',
            subtitle: 'Próximamente',
            enabled: false,
          ),

          _MenuCard(
            icon: Icons.picture_as_pdf,
            title: 'Reportes PDF',
            subtitle: 'Próximamente',
            enabled: false,
          ),

          _MenuCard(
            icon: Icons.settings,
            title: 'Configuración',
            subtitle: 'Próximamente',
            enabled: false,
          ),
        ],
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final bool enabled;

  const _MenuCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(icon),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: enabled ? null : Colors.grey,
          ),
        ),
        subtitle: Text(subtitle),
        trailing: enabled
            ? const Icon(Icons.chevron_right)
            : const Icon(Icons.lock_outline),
        onTap: enabled ? onTap : null,
      ),
    );
  }
}