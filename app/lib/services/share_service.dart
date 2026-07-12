import 'package:share_plus/share_plus.dart';

import '../models/electrical_project.dart';

class ShareService {
  ShareService._();

  //--------------------------------------------------
  // Compartir Proyecto
  //--------------------------------------------------

  static Future<void> compartirProyecto(
      ElectricalProject proyecto,
      ) async {
    final texto = '''
══════════════════════════════

⚡ ElectroChile PRO ⚡

Proyecto : ${proyecto.nombre}

Tipo : ${proyecto.tipo}

Fecha : ${proyecto.fecha}

--------------------------------------

Voltaje : ${proyecto.voltajeTexto}

Corriente : ${proyecto.corrienteTexto}

Longitud : ${proyecto.longitudTexto}

Conductor : ${proyecto.conductorTexto}

Protección : ${proyecto.proteccionTexto}

Diferencial : ${proyecto.diferencial}

Caída : ${proyecto.caidaTexto}

Porcentaje : ${proyecto.porcentajeTexto}

--------------------------------------

Estado :

${proyecto.cumple ? "✅ Cumple SEC" : "❌ No cumple SEC"}

--------------------------------------

Observaciones

${proyecto.observacion}

══════════════════════════════

Generado con ElectroChile PRO
''';

    await SharePlus.instance.share(
      ShareParams(
        text: texto,
        subject: "Proyecto ${proyecto.nombre}",
      ),
    );
  }
}