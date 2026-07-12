import 'package:flutter/material.dart';

import '../../../models/electrical_project.dart';

class ProjectCard extends StatelessWidget {

  final ElectricalProject proyecto;

  final VoidCallback onTap;

  final VoidCallback onDelete;

  final VoidCallback onShare;

  const ProjectCard({

    super.key,

    required this.proyecto,

    required this.onTap,

    required this.onDelete,

    required this.onShare,

  });

  @override
  Widget build(BuildContext context) {

    return Card(

      elevation: 5,

      margin: const EdgeInsets.only(
        bottom: 18,
      ),

      shape: RoundedRectangleBorder(

        borderRadius:
        BorderRadius.circular(18),

      ),

      child: InkWell(

        borderRadius:
        BorderRadius.circular(18),

        onTap: onTap,

        child: Padding(

          padding:
          const EdgeInsets.all(18),

          child: Row(

            crossAxisAlignment:
            CrossAxisAlignment.start,

            children: [

              CircleAvatar(

                radius: 26,

                backgroundColor:

                proyecto.cumple

                    ? Colors.green

                    : Colors.red,

                child: Icon(

                  proyecto.cumple

                      ? Icons.check

                      : Icons.close,

                  color: Colors.white,

                ),

              ),

              const SizedBox(width: 18),

              Expanded(

                child: Column(

                  crossAxisAlignment:
                  CrossAxisAlignment.start,

                  children: [

                    Text(

                      proyecto.nombre.toUpperCase(),

                      style:
                      const TextStyle(

                        fontSize: 18,

                        fontWeight:
                        FontWeight.bold,

                      ),

                    ),

                    const SizedBox(height: 4),

                    Text(

                      proyecto.tipo,

                      style: TextStyle(

                        color:
                        Colors.grey.shade700,

                      ),

                    ),

                    const SizedBox(height: 14),

                    Row(

                      children: [

                        const Icon(

                          Icons.bolt,

                          size: 18,

                          color: Colors.orange,

                        ),

                        const SizedBox(width: 6),

                        Text(
                          proyecto.voltajeTexto,
                        ),

                        const SizedBox(width: 18),

                        const Icon(

                          Icons.electric_bolt,

                          size: 18,

                          color: Colors.blue,

                        ),

                        const SizedBox(width: 6),

                        Text(
                          proyecto.corrienteTexto,
                        ),

                      ],

                    ),

                    const SizedBox(height: 10),

                    Row(

                      children: [

                        const Icon(

                          Icons.straighten,

                          size: 18,

                        ),

                        const SizedBox(width: 6),

                        Text(
                          proyecto.longitudTexto,
                        ),

                        const SizedBox(width: 18),

                        const Icon(

                          Icons.cable,

                          size: 18,

                        ),

                        const SizedBox(width: 6),

                        Text(
                          proyecto.conductorTexto,
                        ),

                      ],

                    ),

                    const SizedBox(height: 14),

                    Container(

                      padding:
                      const EdgeInsets.symmetric(

                        horizontal: 10,

                        vertical: 6,

                      ),

                      decoration: BoxDecoration(

                        color:

                        proyecto.cumple

                            ? Colors.green.shade50

                            : Colors.red.shade50,

                        borderRadius:

                        BorderRadius.circular(10),

                      ),

                      child: Text(

                        proyecto.cumple

                            ? "✅ Cumple SEC"

                            : "❌ No cumple",

                        style: TextStyle(

                          color:

                          proyecto.cumple

                              ? Colors.green

                              : Colors.red,

                          fontWeight:
                          FontWeight.bold,

                        ),

                      ),

                    ),

                  ],

                ),

              ),

              PopupMenuButton<int>(

                onSelected: (value) {

                  switch (value) {

                    case 1:

                      onShare();

                      break;

                    case 2:

                      onDelete();

                      break;

                  }

                },

                itemBuilder: (_) => [

                  const PopupMenuItem(

                    value: 1,

                    child: Row(

                      children: [

                        Icon(Icons.share),

                        SizedBox(width: 10),

                        Text("Compartir"),

                      ],

                    ),

                  ),

                  const PopupMenuItem(

                    value: 2,

                    child: Row(

                      children: [

                        Icon(

                          Icons.delete,

                          color: Colors.red,

                        ),

                        SizedBox(width: 10),

                        Text(

                          "Eliminar",

                          style: TextStyle(

                            color: Colors.red,

                          ),

                        ),

                      ],

                    ),

                  ),

                ],

              ),

            ],

          ),

        ),

      ),

    );

  }

}