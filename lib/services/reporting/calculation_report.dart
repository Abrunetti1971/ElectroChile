import '../../models/circuit.dart';
import '../ric/ric_inspector.dart';
import '../../models/project.dart';

class CalculationReport {
  const CalculationReport();

  String build({
    required Project project,
    required Circuit circuit,
    required double voltageDrop,
  }) {
    final inspection = const RicInspector().inspect(
      circuit: circuit,
      voltageDrop: voltageDrop,
    );

    final buffer = StringBuffer();

    buffer.writeln(
        "========================================");
    buffer.writeln("MEMORIA DE CÁLCULO");
    buffer.writeln(
        "========================================");
    buffer.writeln();
    buffer.writeln("Proyecto");
    buffer.writeln("---------");

    buffer.writeln("Nombre: ${project.name}");

    if (project.client.isNotEmpty) {
      buffer.writeln("Cliente: ${project.client}");
    }

    if (project.address.isNotEmpty) {
      buffer.writeln("Dirección: ${project.address}");
    }

    if (project.city.isNotEmpty) {
      buffer.writeln("Comuna: ${project.city}");
    }

    if (project.region.isNotEmpty) {
      buffer.writeln("Región: ${project.region}");
    }

    if (project.distributor.isNotEmpty) {
      buffer.writeln("Distribuidora: ${project.distributor}");
    }

    buffer.writeln(
      "Fecha: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
    );

    buffer.writeln();
    buffer.writeln("Circuito");
    buffer.writeln("---------");
    buffer.writeln("Nombre: ${circuit.name}");
    buffer.writeln("Tipo: ${circuit.type}");
    buffer.writeln(
        "Voltaje: ${circuit.voltage.toStringAsFixed(0)} V");
    buffer.writeln(
        "Potencia: ${circuit.power.toStringAsFixed(0)} W");
    buffer.writeln(
        "Corriente: ${circuit.current.toStringAsFixed(2)} A");
    buffer.writeln();

    buffer.writeln("Dimensionamiento");
    buffer.writeln("----------------");
    buffer.writeln(
        "Conductor: ${circuit.conductorSection.toStringAsFixed(1)} mm²");
    buffer.writeln("Material: ${circuit.conductorMaterial}");
    buffer.writeln("Protección: ${circuit.protection}");
    buffer.writeln("Diferencial: ${circuit.differential}");
    buffer.writeln("Canalización: ${circuit.conduit}");
    buffer.writeln("Tierra: ${circuit.earth}");
    buffer.writeln(
        "Caída de tensión: ${voltageDrop.toStringAsFixed(2)} %");
    buffer.writeln();

    buffer.writeln("Verificación RIC");
    buffer.writeln("----------------");

    buffer.writeln(
        "${inspection.sectionOk ? '✔' : '✘'} Sección mínima");

    buffer.writeln(
        "${inspection.breakerOk ? '✔' : '✘'} Protección");

    buffer.writeln(
        "${inspection.differentialOk ? '✔' : '✘'} Diferencial");

    buffer.writeln(
        "${inspection.voltageDropOk ? '✔' : '✘'} Caída de tensión");

    buffer.writeln(
        "${inspection.earthOk ? '✔' : '✘'} Tierra");

    buffer.writeln(
        "${inspection.conduitOk ? '✔' : '✘'} Canalización");

    buffer.writeln();

    buffer.writeln(
        "Resultado Final");

    buffer.writeln(
        "----------------");

    buffer.writeln(
      inspection.complies
          ? "✔ EL CIRCUITO CUMPLE RIC"
          : "✘ EL CIRCUITO PRESENTA OBSERVACIONES",
    );

    if (inspection.errors.isNotEmpty) {
      buffer.writeln();
      buffer.writeln("Errores");

      for (final e in inspection.errors) {
        buffer.writeln("- $e");
      }
    }

    if (inspection.warnings.isNotEmpty) {
      buffer.writeln();
      buffer.writeln("Observaciones");

      for (final w in inspection.warnings) {
        buffer.writeln("- $w");
      }
    }

    return buffer.toString();
  }
}