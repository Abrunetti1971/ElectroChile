
import 'dart:typed_data';

import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../models/project.dart';
import '../../models/circuit.dart';
import '../ric/ric_inspector.dart';

class PdfReportService {
  const PdfReportService();

  Future<Uint8List> build({
    required Project project,
    required Circuit circuit,
    required double voltageDrop,
  }) async {
    final pdf = pw.Document();
    final inspection = const RicInspector().inspect(
      circuit: circuit,
      voltageDrop: voltageDrop,
    );
    final date = DateFormat('dd/MM/yyyy').format(DateTime.now());

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (_) => [
          pw.Header(
            child: pw.Text(
              'ELECTROCHILE PRO\nMEMORIA DE CÁLCULO ELÉCTRICO',
              style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
            ),
          ),
          pw.Text('Proyecto: ${project.name}'),
          if (project.client.isNotEmpty) pw.Text('Cliente: ${project.client}'),
          if (project.address.isNotEmpty) pw.Text('Dirección: ${project.address}'),
          if (project.city.isNotEmpty) pw.Text('Comuna: ${project.city}'),
          if (project.region.isNotEmpty) pw.Text('Región: ${project.region}'),
          if (project.distributor.isNotEmpty) pw.Text('Distribuidora: ${project.distributor}'),
          pw.Text('Fecha: $date'),
          pw.SizedBox(height: 12),
          pw.Text('Circuito ${circuit.number}: ${circuit.name}', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          pw.Text('Tipo: ${circuit.type}'),
          pw.Text('Voltaje: ${circuit.voltage.toStringAsFixed(0)} V'),
          pw.Text('Potencia: ${circuit.power.toStringAsFixed(0)} W'),
          pw.Text('Corriente: ${circuit.current.toStringAsFixed(2)} A'),
          pw.SizedBox(height: 12),
          pw.Text('Conductor: ${circuit.conductorSection.toStringAsFixed(1)} mm² ${circuit.conductorMaterial}'),
          pw.Text('Protección: ${circuit.protection}'),
          pw.Text('Diferencial: ${circuit.differential}'),
          pw.Text('Canalización: ${circuit.conduit}'),
          pw.Text('Tierra: ${circuit.earth}'),
          pw.Text('Caída de tensión: ${voltageDrop.toStringAsFixed(2)} %'),
          pw.SizedBox(height: 12),
          pw.Text('Verificación RIC', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          pw.Bullet(text: '${inspection.sectionOk ? "✔" : "✘"} Sección'),
          pw.Bullet(text: '${inspection.breakerOk ? "✔" : "✘"} Protección'),
          pw.Bullet(text: '${inspection.differentialOk ? "✔" : "✘"} Diferencial'),
          pw.Bullet(text: '${inspection.conduitOk ? "✔" : "✘"} Canalización'),
          pw.Bullet(text: '${inspection.earthOk ? "✔" : "✘"} Tierra'),
          pw.Bullet(text: '${inspection.voltageDropOk ? "✔" : "✘"} Caída de tensión'),
          pw.SizedBox(height: 12),
          pw.Text(
            inspection.complies ? 'RESULTADO: CUMPLE RIC' : 'RESULTADO: PRESENTA OBSERVACIONES',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
          ),
        ],
      ),
    );

    return pdf.save();
  }
}
