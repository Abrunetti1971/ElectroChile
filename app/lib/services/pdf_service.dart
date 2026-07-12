import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../models/electrical_project.dart';

class PdfService {
PdfService._();

//--------------------------------------------------
// Generar PDF del Proyecto
//--------------------------------------------------

static Future<void> generarProyecto(
ElectricalProject proyecto,
) async {

final pdf = pw.Document();

final fecha = DateFormat(
'dd/MM/yyyy HH:mm',
).format(
proyecto.fecha,
);

pdf.addPage(

pw.MultiPage(

pageFormat: PdfPageFormat.a4,

margin: const pw.EdgeInsets.all(30),

build: (context) {

return [

//--------------------------------------------------
// Encabezado
//--------------------------------------------------

pw.Center(

child: pw.Column(

children: [

pw.Text(
'⚡ ElectroChile PRO',
style: pw.TextStyle(
fontSize: 26,
fontWeight: pw.FontWeight.bold,
),
),

pw.SizedBox(height: 6),

pw.Text(
'Informe Técnico Eléctrico',
style: const pw.TextStyle(
fontSize: 15,
),
),

pw.SizedBox(height: 20),

],

),

),
//--------------------------------------------------
// Información del proyecto
//--------------------------------------------------

pw.Container(
width: double.infinity,
padding: const pw.EdgeInsets.all(12),
decoration: pw.BoxDecoration(
border: pw.Border.all(),
borderRadius: pw.BorderRadius.circular(6),
),
child: pw.Column(
crossAxisAlignment: pw.CrossAxisAlignment.start,
children: [

pw.Text(
'Información General',
style: pw.TextStyle(
fontWeight: pw.FontWeight.bold,
fontSize: 16,
),
),

pw.SizedBox(height: 10),

pw.Text('Proyecto: ${proyecto.nombre}'),

pw.Text('Tipo: ${proyecto.tipo}'),

pw.Text('Fecha: $fecha'),

],
),
),

pw.SizedBox(height: 20),

//--------------------------------------------------
// Datos eléctricos
//--------------------------------------------------

pw.Text(
'Datos Técnicos',
style: pw.TextStyle(
fontWeight: pw.FontWeight.bold,
fontSize: 18,
),
),

pw.SizedBox(height: 10),

pw.Table(
border: pw.TableBorder.all(),
children: [

_fila(
'Voltaje',
proyecto.voltajeTexto,
),

_fila(
'Corriente',
proyecto.corrienteTexto,
),

_fila(
'Longitud',
proyecto.longitudTexto,
),

_fila(
'Material',
proyecto.material,
),

_fila(
'Sistema',
proyecto.sistema,
),

_fila(
'Conductor',
proyecto.conductorTexto,
),

_fila(
'Protección',
proyecto.proteccionTexto,
),

_fila(
'Diferencial',
proyecto.diferencial,
),

_fila(
'Caída',
proyecto.caidaTexto,
),

_fila(
'Porcentaje',
proyecto.porcentajeTexto,
),

],
),

pw.SizedBox(height: 20),
  //--------------------------------------------------
  // Estado
  //--------------------------------------------------

  pw.Text(
    'Estado',
    style: pw.TextStyle(
      fontWeight: pw.FontWeight.bold,
      fontSize: 18,
    ),
  ),

  pw.SizedBox(height: 10),

  pw.Container(
    padding: const pw.EdgeInsets.all(10),
    decoration: pw.BoxDecoration(
      border: pw.Border.all(),
    ),
    child: pw.Text(
      proyecto.cumple
          ? '✔ Cumple SEC'
          : '✘ No cumple SEC',
      style: pw.TextStyle(
        fontWeight: pw.FontWeight.bold,
        color: proyecto.cumple
            ? PdfColors.green
            : PdfColors.red,
      ),
    ),
  ),

  pw.SizedBox(height: 20),

  //--------------------------------------------------
  // Observaciones
  //--------------------------------------------------

  pw.Text(
    'Observaciones',
    style: pw.TextStyle(
      fontWeight: pw.FontWeight.bold,
      fontSize: 18,
    ),
  ),

  pw.SizedBox(height: 10),

  pw.Container(
    width: double.infinity,
    padding: const pw.EdgeInsets.all(12),
    decoration: pw.BoxDecoration(
      border: pw.Border.all(),
    ),
    child: pw.Text(
      proyecto.observacion,
    ),
  ),

  pw.SizedBox(height: 30),

  pw.Center(
    child: pw.Text(
      'Generado por ElectroChile PRO',
      style: const pw.TextStyle(
        fontSize: 11,
      ),
    ),
  ),

];

},

),

);

await Printing.layoutPdf(
  onLayout: (PdfPageFormat format) async =>
      pdf.save(),
);

}

  //--------------------------------------------------
  // Fila de tabla
  //--------------------------------------------------

  static pw.TableRow _fila(
      String titulo,
      String valor,
      ) {
    return pw.TableRow(
      children: [

        pw.Padding(
          padding: const pw.EdgeInsets.all(8),
          child: pw.Text(
            titulo,
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        ),

        pw.Padding(
          padding: const pw.EdgeInsets.all(8),
          child: pw.Text(valor),
        ),

      ],
    );
  }
}