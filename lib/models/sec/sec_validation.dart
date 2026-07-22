/// Estado de una validación SEC/RIC.
enum SecValidationStatus {
  passed,
  warning,
  failed,
  pending,
}

/// Resultado de una validación técnica.
///
/// Esta clase representa una observación generada por los distintos
/// servicios de validación (RIC, TE1, Proyecto, etc.).
class SecValidation {
  /// Código interno de la validación.
  ///
  /// Ejemplo:
  /// RIC-06-001
  /// TE1-003
  /// PROJECT-001
  final String code;

  /// Título corto mostrado al usuario.
  final String title;

  /// Descripción técnica del problema o validación.
  final String description;

  /// Recomendación para solucionar la observación.
  final String recommendation;

  /// Referencia normativa.
  ///
  /// Ejemplo:
  /// RIC 06
  /// RIC 10
  /// Decreto Supremo N°8
  final String regulation;

  /// Estado de la validación.
  final SecValidationStatus status;

  const SecValidation({
    required this.code,
    required this.title,
    required this.description,
    required this.recommendation,
    required this.regulation,
    required this.status,
  });

  bool get isPassed => status == SecValidationStatus.passed;

  bool get isWarning => status == SecValidationStatus.warning;

  bool get isFailed => status == SecValidationStatus.failed;

  bool get isPending => status == SecValidationStatus.pending;

  bool get isSuccess => isPassed;

  String get statusText {
    switch (status) {
      case SecValidationStatus.passed:
        return 'Correcto';

      case SecValidationStatus.warning:
        return 'Observación';

      case SecValidationStatus.failed:
        return 'Error';

      case SecValidationStatus.pending:
        return 'Pendiente';
    }
  }

  SecValidation copyWith({
    String? code,
    String? title,
    String? description,
    String? recommendation,
    String? regulation,
    SecValidationStatus? status,
  }) {
    return SecValidation(
      code: code ?? this.code,
      title: title ?? this.title,
      description: description ?? this.description,
      recommendation: recommendation ?? this.recommendation,
      regulation: regulation ?? this.regulation,
      status: status ?? this.status,
    );
  }

  @override
  String toString() {
    return 'SecValidation('
        'code: $code, '
        'title: $title, '
        'status: $status'
        ')';
  }
}