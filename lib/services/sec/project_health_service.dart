import '../../models/sec/sec_validation.dart';

class ProjectHealthResult {
  final int score;
  final int total;
  final int passed;
  final int warnings;
  final int failed;
  final int pending;

  const ProjectHealthResult({
    required this.score,
    required this.total,
    required this.passed,
    required this.warnings,
    required this.failed,
    required this.pending,
  });

  bool get isReady =>
      failed == 0 && pending == 0;

  String get status {
    if (failed > 0) {
      return 'No apto';
    }

    if (warnings > 0 || pending > 0) {
      return 'Apto con observaciones';
    }

    return 'Listo para declarar';
  }
}

class ProjectHealthService {
  ProjectHealthResult evaluate(
      List<SecValidation> validations,
      ) {
    final total = validations.length;

    final passed = validations
        .where((e) => e.isPassed)
        .length;

    final warnings = validations
        .where((e) => e.isWarning)
        .length;

    final failed = validations
        .where((e) => e.isFailed)
        .length;

    final pending = validations
        .where((e) => e.isPending)
        .length;

    int score = 0;

    if (total > 0) {
      score = ((passed / total) * 100).round();
    }

    return ProjectHealthResult(
      score: score,
      total: total,
      passed: passed,
      warnings: warnings,
      failed: failed,
      pending: pending,
    );
  }
}