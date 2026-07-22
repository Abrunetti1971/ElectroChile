import '../../models/project.dart';
import '../../models/circuit.dart';
import '../load_summary_service.dart';

class ProjectReport {
  final Project project;
  final List<Circuit> circuits;
  final LoadSummary loadSummary;
  final DateTime createdAt;
  final List<String> observations;

  const ProjectReport({
    required this.project,
    required this.circuits,
    required this.loadSummary,
    required this.createdAt,
    required this.observations,
  });
}

class ProjectReportService {
  const ProjectReportService();

  ProjectReport build({
    required Project project,
    required List<Circuit> circuits,
  }) {
    final summary = const LoadSummaryService().build(circuits);

    final observations = <String>[];

    if (!summary.ricCompliant) {
      observations.addAll(summary.warnings);
    }

    if (circuits.isEmpty) {
      observations.add('El proyecto no contiene circuitos.');
    }

    return ProjectReport(
      project: project,
      circuits: circuits,
      loadSummary: summary,
      createdAt: DateTime.now(),
      observations: observations,
    );
  }

  String buildExecutiveSummary(ProjectReport report) {
    return '''
Proyecto: ${report.project.name}
Cliente: ${report.project.client}

Circuitos: ${report.circuits.length}
Potencia instalada: ${report.loadSummary.installedPower.toStringAsFixed(1)} W
Corriente instalada: ${report.loadSummary.installedCurrent.toStringAsFixed(2)} A

Interruptor General: ${report.loadSummary.mainBreaker}
Diferencial General: ${report.loadSummary.mainDifferential}

Estado RIC: ${report.loadSummary.ricCompliant ? "CONFORME" : "CON OBSERVACIONES"}
''';
  }
}
