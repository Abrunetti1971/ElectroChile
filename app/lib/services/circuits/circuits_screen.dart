import 'package:flutter/material.dart';

class CircuitsScreen extends StatefulWidget {
  final String projectName;

  const CircuitsScreen({
    super.key,
    required this.projectName,
  });

  @override
  State<CircuitsScreen> createState() => _CircuitsScreenState();
}

class _CircuitsScreenState extends State<CircuitsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Circuitos"),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "Próximamente: Nuevo Circuito",
              ),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text("Nuevo"),
      ),

      body: Column(
        children: [

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            color: Colors.blue.shade50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  widget.projectName,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  "Proyecto Eléctrico",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),

                const SizedBox(height: 15),

                Row(
                  children: const [

                    Icon(
                      Icons.electrical_services,
                      color: Colors.blue,
                    ),

                    SizedBox(width: 8),

                    Text(
                      "Circuitos registrados: 0",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                  ],
                ),

              ],
            ),
          ),

          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [

                  Icon(
                    Icons.cable,
                    size: 90,
                    color: Colors.grey,
                  ),

                  SizedBox(height: 20),

                  Text(
                    "Este proyecto aún no tiene circuitos",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 10),

                  Text(
                    "Presiona 'Nuevo' para crear el primer circuito.",
                    textAlign: TextAlign.center,
                  ),

                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}