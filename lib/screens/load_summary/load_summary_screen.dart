import 'package:flutter/material.dart';

import '../../models/load_summary.dart';

class LoadSummaryScreen extends StatelessWidget {
  final LoadSummary summary;

  const LoadSummaryScreen({
    super.key,
    required this.summary,
  });

  Widget _row(
      String title,
      String value,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 6,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(value),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Cuadro de Cargas",
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [

          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [

                  const Text(
                    "Circuitos",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  ...summary.circuits.map(
                        (circuit) {
                      return Card(
                        elevation: 0,
                        color: Colors.blue.shade50,
                        child: ListTile(
                          title: Text(
                            circuit.name,
                          ),
                          subtitle: Text(
                            "${circuit.type}\n"
                                "${circuit.power.toStringAsFixed(0)} W",
                          ),
                          trailing: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              Text(
                                "${circuit.current.toStringAsFixed(2)} A",
                              ),
                              Text(
                                "${circuit.conductorSection} mm²",
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 18),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                children: [

                  _row(
                    "Circuitos",
                    summary.circuitsCount.toString(),
                  ),

                  _row(
                    "Potencia instalada",
                    "${summary.installedPower.toStringAsFixed(0)} W",
                  ),

                  _row(
                    "Potencia demandada",
                    "${summary.demandPower.toStringAsFixed(0)} W",
                  ),

                  _row(
                    "Corriente total",
                    "${summary.totalCurrent.toStringAsFixed(2)} A",
                  ),

                  _row(
                    "Alimentador",
                    "${summary.feederSection.toStringAsFixed(1)} mm²",
                  ),

                  _row(
                    "Disyuntor General",
                    "${summary.mainBreaker} A",
                  ),

                  _row(
                    "Diferencial",
                    summary.differential,
                  ),

                  _row(
                    "Empalme",
                    summary.recommendedService,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}