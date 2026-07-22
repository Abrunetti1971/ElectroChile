import 'package:flutter/material.dart';

import '../../models/project.dart';
import '../../models/circuit.dart';
import '../../services/load_summary_service.dart';

class LoadSummaryScreen extends StatelessWidget {
  final Project project;
  final List<Circuit> circuits;

  const LoadSummaryScreen({
    super.key,
    required this.project,
    required this.circuits,
  });

  @override
  Widget build(BuildContext context) {
    final summary = const LoadSummaryService().build(circuits);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resumen de Cargas'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              title: Text(project.name),
              subtitle: Text(
                  '${project.client}\n${project.address}\n${project.city}'),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _row('Potencia instalada',
                      '${summary.installedPower.toStringAsFixed(1)} W'),
                  _row('Corriente instalada',
                      '${summary.installedCurrent.toStringAsFixed(2)} A'),
                  _row('Potencia demandada',
                      '${summary.demandPower.toStringAsFixed(1)} W'),
                  _row('Corriente demandada',
                      '${summary.demandCurrent.toStringAsFixed(2)} A'),
                  _row('Interruptor General', summary.mainBreaker),
                  _row('Diferencial General', summary.mainDifferential),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text('Circuitos',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          DataTable(
            columns: const [
              DataColumn(label: Text('N°')),
              DataColumn(label: Text('Circuito')),
              DataColumn(label: Text('W')),
              DataColumn(label: Text('A')),
              DataColumn(label: Text('Prot.')),
            ],
            rows: summary.circuits
                .map(
                  (c) => DataRow(cells: [
                    DataCell(Text('${c.number}')),
                    DataCell(Text(c.name)),
                    DataCell(Text(c.power.toStringAsFixed(0))),
                    DataCell(Text(c.current.toStringAsFixed(2))),
                    DataCell(Text(c.protection)),
                  ]),
                )
                .toList(),
          ),
          const SizedBox(height: 16),
          Card(
            color: summary.ricCompliant
                ? Colors.green.shade50
                : Colors.orange.shade50,
            child: ListTile(
              leading: Icon(
                  summary.ricCompliant ? Icons.check_circle : Icons.warning),
              title: Text(summary.ricCompliant
                  ? 'Proyecto conforme'
                  : 'Proyecto con observaciones'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _row(String t, String v) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(t), Text(v)],
        ),
      );
}
