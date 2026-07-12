import 'package:flutter/material.dart';

import '../home/home_screen.dart';
import '../calculators/calculators_screen.dart';

class ShellScreen extends StatefulWidget {
  const ShellScreen({super.key});

  @override
  State<ShellScreen> createState() => _ShellScreenState();
}

class _ShellScreenState extends State<ShellScreen> {

  int currentIndex = 0;

  final List<Widget> pages = const [

    HomeScreen(),

    CalculatorsScreen(),

    Center(
      child: Text(
        "Mis Proyectos\n(Próximamente)",
        textAlign: TextAlign.center,
      ),
    ),

    Center(
      child: Text(
        "Biblioteca SEC\n(Próximamente)",
        textAlign: TextAlign.center,
      ),
    ),

    Center(
      child: Text(
        "Configuración\n(Próximamente)",
        textAlign: TextAlign.center,
      ),
    ),

  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: IndexedStack(

        index: currentIndex,

        children: pages,

      ),

      bottomNavigationBar: NavigationBar(

        selectedIndex: currentIndex,

        onDestinationSelected: (index) {

          setState(() {

            currentIndex = index;

          });

        },

        destinations: const [

          NavigationDestination(

            icon: Icon(Icons.home_outlined),

            selectedIcon: Icon(Icons.home),

            label: "Inicio",

          ),

          NavigationDestination(

            icon: Icon(Icons.calculate_outlined),

            selectedIcon: Icon(Icons.calculate),

            label: "Calculadoras",

          ),

          NavigationDestination(

            icon: Icon(Icons.folder_outlined),

            selectedIcon: Icon(Icons.folder),

            label: "Proyectos",

          ),

          NavigationDestination(

            icon: Icon(Icons.menu_book_outlined),

            selectedIcon: Icon(Icons.menu_book),

            label: "Biblioteca",

          ),

          NavigationDestination(

            icon: Icon(Icons.settings_outlined),

            selectedIcon: Icon(Icons.settings),

            label: "Config.",

          ),

        ],

      ),

    );

  }

}