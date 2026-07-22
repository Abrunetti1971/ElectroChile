enum RicSeverity {
  info,
  warning,
  error,
}

extension RicSeverityX on RicSeverity {
  int get weight {
    switch (this) {
      case RicSeverity.info:
        return 1;
      case RicSeverity.warning:
        return 2;
      case RicSeverity.error:
        return 3;
    }
  }

  String get label {
    switch (this) {
      case RicSeverity.info:
        return 'Información';
      case RicSeverity.warning:
        return 'Advertencia';
      case RicSeverity.error:
        return 'Error';
    }
  }
}

class RicValidationResult {
  final String validatorId;
  final String code;
  final String title;
  final String message;
  final String recommendation;
  final String ricReference;
  final RicSeverity severity;
  final String? circuitId;
  final int? circuitNumber;

  const RicValidationResult({
    required this.validatorId,
    required this.code,
    required this.title,
    required this.message,
    required this.severity,
    this.recommendation = '',
    this.ricReference = '',
    this.circuitId,
    this.circuitNumber,
  });

  bool get isError => severity == RicSeverity.error;
  bool get isWarning => severity == RicSeverity.warning;
  bool get isInfo => severity == RicSeverity.info;
  bool get belongsToCircuit => circuitId != null || circuitNumber != null;

  RicValidationResult copyWith({
    String? validatorId,
    String? code,
    String? title,
    String? message,
    String? recommendation,
    String? ricReference,
    RicSeverity? severity,
    String? circuitId,
    int? circuitNumber,
    bool clearCircuitId = false,
    bool clearCircuitNumber = false,
  }) {
    return RicValidationResult(
      validatorId: validatorId ?? this.validatorId,
      code: code ?? this.code,
      title: title ?? this.title,
      message: message ?? this.message,
      recommendation: recommendation ?? this.recommendation,
      ricReference: ricReference ?? this.ricReference,
      severity: severity ?? this.severity,
      circuitId: clearCircuitId ? null : circuitId ?? this.circuitId,
      circuitNumber:
          clearCircuitNumber ? null : circuitNumber ?? this.circuitNumber,
    );
  }

  Map<String, Object?> toMap() {
    return {
      'validator_id': validatorId,
      'code': code,
      'title': title,
      'message': message,
      'recommendation': recommendation,
      'ric_reference': ricReference,
      'severity': severity.name,
      'circuit_id': circuitId,
      'circuit_number': circuitNumber,
    };
  }
}

class RicValidationReport {
  final DateTime generatedAt;
  final List<RicValidationResult> results;
  final int validatorsExecuted;
  final int validatorsFailed;

  RicValidationReport({
    required this.generatedAt,
    required List<RicValidationResult> results,
    required this.validatorsExecuted,
    this.validatorsFailed = 0,
  }) : results = List.unmodifiable(_sorted(results));

  static List<RicValidationResult> _sorted(
    List<RicValidationResult> source,
  ) {
    final copy = List<RicValidationResult>.from(source);

    copy.sort((a, b) {
      final severityComparison =
          b.severity.weight.compareTo(a.severity.weight);

      if (severityComparison != 0) {
        return severityComparison;
      }

      final circuitComparison =
          (a.circuitNumber ?? 0).compareTo(b.circuitNumber ?? 0);

      if (circuitComparison != 0) {
        return circuitComparison;
      }

      return a.code.compareTo(b.code);
    });

    return copy;
  }

  int get errorCount => results.where((result) => result.isError).length;
  int get warningCount => results.where((result) => result.isWarning).length;
  int get infoCount => results.where((result) => result.isInfo).length;

  bool get complies => errorCount == 0;
  bool get hasWarnings => warningCount > 0;
  bool get hasResults => results.isNotEmpty;

  double get compliancePercentage {
    if (results.isEmpty) {
      return 100;
    }

    var penalty = 0.0;

    for (final result in results) {
      switch (result.severity) {
        case RicSeverity.error:
          penalty += 1.0;
        case RicSeverity.warning:
          penalty += 0.5;
        case RicSeverity.info:
          break;
      }
    }

    final percentage = 100 - ((penalty / results.length) * 100);
    return percentage.clamp(0, 100).toDouble();
  }

  List<RicValidationResult> resultsForCircuit(String circuitId) {
    return results
        .where((result) => result.circuitId == circuitId)
        .toList(growable: false);
  }

  Map<String, Object?> toMap() {
    return {
      'generated_at': generatedAt.toIso8601String(),
      'validators_executed': validatorsExecuted,
      'validators_failed': validatorsFailed,
      'complies': complies,
      'compliance_percentage': compliancePercentage,
      'error_count': errorCount,
      'warning_count': warningCount,
      'info_count': infoCount,
      'results': results.map((result) => result.toMap()).toList(),
    };
  }
}
