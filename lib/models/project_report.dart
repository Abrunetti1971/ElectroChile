import 'circuit.dart';
import 'project.dart';
import '../services/load_summary_service.dart';

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

  bool get hasObservations => observations.isNotEmpty;

  int get circuitCount => circuits.length;
}
