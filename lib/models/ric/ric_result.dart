import 'ric_severity.dart';

class RicResult {
  final String ric;
  final String title;
  final String description;
  final String recommendation;
  final RicSeverity severity;
  final bool passed;

  const RicResult({
    required this.ric,
    required this.title,
    required this.description,
    required this.recommendation,
    required this.severity,
    required this.passed,
  });
}